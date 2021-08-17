import 'dart:io';
import 'package:bread_delivery/Services/Http/validationErrorHandler.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Entities/token.dart';
import '../../Services/Http/networkError.dart';
import '../Local/auth.dart';

class DioClient {
  final String baseUrl =
      "https://192.168.1.73:5001/api/"; //Emulator (Esto no jala aun si es emulador)
  // final String baseUrl = "https://10.0.0.6:5001/api/"; //WLAN
  final String urlCuenta = "Cuenta/RefreshCredentials";
  SharedPreferences _storage;
  String accessToken;

  Dio _dio;
  final List<Interceptor> interceptors = <Interceptor>[];

  DioClient() {
    _dio = Dio();

    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 5000
      ..options.receiveTimeout = 3000
      ..httpClientAdapter;
    addInterceptors();
    setCertificateAvoid();

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: false));
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      ValidationErrorHandler.validate(response);
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("El formato no es JSON");
    } catch (e) {
      NetworkError.handleResponse(e);
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      ValidationErrorHandler.validate(response);
      return response.data;
    } on FormatException catch (e) {
      print(e);
    } catch (e) {
      NetworkError.handleResponse(e);
    }
  }

  void requestInterceptor() async {
    accessToken = Auth.getToken(await SharedPreferences.getInstance());
    _dio.options.headers.clear();

    if (accessToken == null) {
      _dio.options.headers.addAll({
        'Content-Type': 'application/json; UTF-8',
      });
    } else {
      accessToken = 'Bearer ' + accessToken;
      _dio.options.headers.addAll({
        'Content-Type': 'application/json; UTF-8',
        'Authorization': accessToken
      });
    }
  }

  void unauthenticateHandlerInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) async {
      if (error.response?.statusCode == 403 ||
          error.response?.statusCode == 401) {
        await refreshToken();
        return _retry(error.error);
      }
      return error.response;
    }));
  }

  void errorHandlerInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) async {
      print(error);
      return NetworkError.handleResponse(error);
    }));
  }

  void addInterceptors() async {
    _dio.interceptors.clear();
    requestInterceptor();
    errorHandlerInterceptor();
    if (accessToken != null) {
      //Can be refreshed
      unauthenticateHandlerInterceptor();
    }
  }

  void setCertificateAvoid() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<void> refreshToken() async {
    _storage = await SharedPreferences.getInstance();
    final refreshToken = Auth.getRefToken(_storage);
    final token = Auth.getToken(_storage);
    final response = await this._dio.post('Cuenta/RefreshCredentials',
        data: RefreshToken(refreshToken: refreshToken, token: token).toJson());

    if (response.statusCode == 200) {
      var token = Token.fromJson(response.data);
      Auth.refreshToken(await SharedPreferences.getInstance(), token);
      accessToken = token.token;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return this._dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
