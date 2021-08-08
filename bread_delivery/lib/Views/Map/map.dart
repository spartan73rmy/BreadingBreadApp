import 'package:bread_delivery/Entities/storePoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapArea extends StatefulWidget {
  final LatLng center;
  final List<StorePoint> points;

  MapArea(this.center, this.points, {Key key}) : super(key: key);
  @override
  _MapAreaState createState() => _MapAreaState();
}

class _MapAreaState extends State<MapArea> {
  var markers = <Marker>[];

  @override
  void initState() {
    markers.addAll(widget.points.map((e) => Marker(
        width: 40.0,
        height: 40.0,
        point: e.point,
        builder: (ctx) => Container(
              child: FlutterLogo(),
            ))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).size.height * 0.35,
      child: FlutterMap(
        options: MapOptions(
          center: widget.center,
          zoom: 15.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(markers: markers)
        ],
      ),
    );
  }
}
