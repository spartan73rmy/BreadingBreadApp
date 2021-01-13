import 'dart:io';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:dio/adapter.dart';

import '../Local/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  // final String baseUrl = "https://localhost:5001/api/";
  final String baseUrl = "https://192.168.0.102:5001/api/";
  final String urlCuenta = "Cuenta/RefreshCredentials";
  SharedPreferences _storage;
  Dio _dio;
  String accessToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiQWRtaW4iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjEiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBZG1pbiIsIm5iZiI6MTYxMDQxNzMzNSwiZXhwIjoxNjEwNDIwOTM1LCJpc3MiOiJCcmVhZGluZ0JyZWFkIiwiYXVkIjoiRXZlcnlvbmUifQ.DsEbrZpcBWnfWam2afP7C1worx01FET6pkXEsSPym78";
  final List<Interceptor> interceptors = new List<Interceptor>();

  DioClient() {
    _dio = Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 5000
      ..options.receiveTimeout = 3000
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; UTF-8',
        'Authorization': 'Bearer ' + accessToken
      };
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(onError: (error) async {
      if (error.response?.statusCode == 403 ||
          error.response?.statusCode == 401) {
        await refreshToken();
        return _retry(error.request);
      }
      return error.response;
    }));

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
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("El formato no es JSON");
    } catch (e) {
      throw e;
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
      return response.data;
    } on FormatException catch (e) {
      throw NetworkError.handleResponse(
          DioError(response: Response(statusCode: 0), error: e.message));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  Future<void> refreshToken() async {
    _storage = await SharedPreferences.getInstance();
    final refreshToken = Auth.getRefToken(_storage);
    final token = Auth.getToken(_storage);

    final response = await this._dio.post('Cuenta/RefreshCredentials',
        data: {'refreshToken': refreshToken, 'token': token});

    if (response.statusCode == 200) {
      this.accessToken = response.data['token'];
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
