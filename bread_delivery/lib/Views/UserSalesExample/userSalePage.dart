import 'package:bread_delivery/BLOC/Sale/bloc/sale_bloc.dart';
import 'package:bread_delivery/CommonWidgets/alertInput.dart';
import 'package:bread_delivery/CommonWidgets/messageScreen.dart';
import 'package:bread_delivery/CommonWidgets/snackBar.dart';
import 'package:bread_delivery/Entities/sale.dart';
import 'package:bread_delivery/Entities/userSaleViewParams.dart';
import 'package:bread_delivery/Enums/Routes.dart';
import 'package:bread_delivery/Services/Sale/SaleRepository.dart';
import 'package:flutter/material.dart';
import 'package:bread_delivery/CommonWidgets/background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bread_delivery/Views/UserSalesExample/userSaleBottomNavBar.dart';
import 'package:bread_delivery/Views/UserSalesExample/userSaleListProducts.dart';
import 'package:bread_delivery/Views/UserSalesExample/userSaleListTotalSale.dart';
import 'package:google_fonts/google_fonts.dart';

class SalePage extends StatefulWidget {
  final UserSaleViewParams currentSale;
  const SalePage(this.currentSale, {Key key}) : super(key: key);

  _SalePage createState() => _SalePage();
}

class _SalePage extends State<SalePage> {
  int indexScreen = 0;
  UserSaleViewParams currentSale;

  @override
  void initState() {
    super.initState();
    currentSale = widget.currentSale;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              centerTitle: true,
              title: Column(children: [
                Text(
                  currentSale.selectedPath.pathName ?? "Ruta",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                Text(
                  currentSale.selectedStore.name ?? "Tienda",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )
              ]),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[Color(0XFF674023), Color(0XFF9E5F32)])),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: BlocListener<SaleBloc, SaleState>(
              listener: (context, state) {
                if (state is SaleError) snackBar(context, state.toString());
              },
              child:
                  BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                if (state is SaleLoading) MessageScreen();
                if (state is SaleOperationCompleted)
                  Navigator.pushReplacementNamed(context, Routes.Stores,
                      arguments: widget.currentSale.selectedPath);

                return _setSectionBody(indexScreen);
              }),
            ),
            bottomSheet: (indexScreen == 0)
                ? null
                : Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                          Color(0XFF674023),
                          Color(0XFF9E5F32)
                        ])),
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Total: \$ ${widget.currentSale.products.fold(0, (value, element) => value + element.total())}',
                              style: GoogleFonts.lora(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: ElevatedButton(
                              child: Text("Cobrar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF1E9431))),
                              onPressed: () async => await _sale(context),
                            ),
                          )
                        ],
                      ),
                    ))),
        Stack(children: <Widget>[
          new Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 55,
                  color: Colors.brown.withOpacity(.7),
                  child: BottomNavBar(
                    functionPath: (value) => {_returnValue(value)},
                  )),
            ),
          ),
        ])
      ],
    );
  }

  _returnValue(value) {
    setState(() {
      indexScreen = value;
    });
    _setSectionBody(indexScreen);
  }

  _setSectionBody(value) {
    switch (value) {
      case 0:
        return ListViewProducts(currentSale);
      case 1:
        return TotalSale(currentSale);
    }
  }

  _sale(BuildContext context) async {
    var total = widget.currentSale.products
        .fold(0, (value, element) => value + element.total());
    var idPath = currentSale.selectedPath.idPath;
    var idStore = currentSale.selectedStore.id;
    var products =
        currentSale.products.where((element) => element.inSale()).toList();
    var commentary = "";

    if (products.isEmpty && total <= 0)
      commentary = await alertInputDiag(
          context,
          "Comentario de Venta",
          "La tienda ...",
          "Comentaro de la tienda",
          "Es necesario introducir la razon porque no se realizo la venta",
          keyboard: TextInputType.text,
          icon: Icon(Icons.store));

    if (commentary == null) {
      await _sale(context);
      return;
    }

    var sale = Sale(idPath, idStore, total, products, commentary);

    BlocProvider.of<SaleBloc>(context).add(AddSale(sale));
  }
}
