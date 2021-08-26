import 'package:bread_delivery/Entities/store.dart';
import 'package:flutter/material.dart';

Future<List<Store>> addStoresToPath(
    BuildContext context, List<Store> storesAvailable) {
  return showDialog(
      context: context,
      builder: (context) {
        return SelectStoresByPath(storesAvailable);
      });
}

class SelectStoresByPath extends StatefulWidget {
  final List<Store> allStores;
  SelectStoresByPath(this.allStores, {Key key}) : super(key: key);

  @override
  _SelectStoresByPathState createState() => _SelectStoresByPathState();
}

class _SelectStoresByPathState extends State<SelectStoresByPath> {
  final selected = <Store>[];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Agregar tiendas a ruta")),
      content: Container(
          height: 400.0,
          width: 300.0,
          child: ListView.builder(
              itemCount: widget.allStores.length,
              padding: EdgeInsets.all(2.0),
              itemBuilder: (context, i) {
                return buildRow(widget.allStores[i]);
              })),
      actions: <Widget>[
        TextButton(
          child: Text("Aceptar"),
          onPressed: () {
            Navigator.pop(
                context, selected); //Se retornan las rutas seleccionadas
          },
        )
      ],
    );
  }

  Widget buildRow(Store store) {
    final alreadySaved = selected.contains(store);
    return ListTile(
      trailing: Icon(
        alreadySaved ? Icons.check_box : Icons.check_box_outline_blank,
        color: alreadySaved ? Theme.of(context).primaryColorDark : null,
      ),
      title: Text(
        store.name,
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            selected.remove(store);
          } else {
            selected.add(store);
          }
        });
      },
    );
  }
}
