import 'package:bread_delivery/Entities/storePoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapArea extends StatefulWidget {
  MapArea({Key key}) : super(key: key);

  @override
  _MapAreaState createState() => _MapAreaState();
}

class _MapAreaState extends State<MapArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).size.height * 0.35,
      child: FlutterMap(
        options: MapOptions(
          center: widget.point,
          zoom: 15.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: [
              //TODO pasar una lista de puntos y hacer los marcadores
              Marker(
                width: 40.0,
                height: 40.0,
                point: widget.point,
                builder: (ctx) => Container(
                  child: FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
