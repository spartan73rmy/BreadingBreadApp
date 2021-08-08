import 'package:bread_delivery/Entities/storePoint.dart';
import 'package:bread_delivery/Views/Map/pinMarker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';

class MapArea extends StatefulWidget {
  //Centro Morelia Mich.
  final LatLng center = LatLng(19.7037327, -101.2411436);
  final List<StorePoint> points;

  MapArea(this.points, {Key key}) : super(key: key);
  @override
  _MapAreaState createState() => _MapAreaState();
}

class _MapAreaState extends State<MapArea> {
  var markers = <Marker>[];
  CenterOnLocationUpdate _centerOnLocationUpdate;
  StreamController<double> _centerCurrentLocationStreamController;

  @override
  void initState() {
    _centerOnLocationUpdate = CenterOnLocationUpdate.always;
    _centerCurrentLocationStreamController = StreamController<double>();
    markers.addAll(widget.points.map((e) => Marker(
        width: 40.0,
        height: 40.0,
        point: e.point,
        builder: (ctx) => PinMarker(e.nombre))));
    super.initState();
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          // alignment: Alignment.topCenter,
          // height: MediaQuery.of(context).size.height * 0.35,
          child: FlutterMap(
              options: MapOptions(
                  center: widget.center,
                  zoom: 15.0,
                  plugins: [
                    // MarkerClusterPlugin(),
                  ],
                  onPositionChanged: (MapPosition position, bool hasGesture) {
                    if (hasGesture) {
                      setState(() => _centerOnLocationUpdate =
                          CenterOnLocationUpdate.never);
                    }
                  }),
              layers: [
            MarkerLayerOptions(markers: markers)
          ],
              children: [
            TileLayerWidget(
              options: TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                maxZoom: 19,
              ),
            ),
            LocationMarkerLayerWidget(
                plugin: LocationMarkerPlugin(
              centerCurrentLocationStream:
                  _centerCurrentLocationStreamController.stream,
              centerOnLocationUpdate: _centerOnLocationUpdate,
            ))
          ])),
      Positioned(
        right: 20,
        bottom: 20,
        child: FloatingActionButton(
          onPressed: () {
            // Automatically center the location marker on the map when location updated until user interact with the map.
            setState(
                () => _centerOnLocationUpdate = CenterOnLocationUpdate.always);
            // Center the location marker on the map and zoom the map to level 18.
            _centerCurrentLocationStreamController.add(18);
          },
          child: Icon(
            Icons.my_location,
            color: Colors.white,
          ),
        ),
      ),
    ]);
  }
}
