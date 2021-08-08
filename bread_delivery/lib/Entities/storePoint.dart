import 'package:latlong2/latlong.dart';

class StorePoints {
  final List<StorePoint> points;

  StorePoints(this.points);
}

class StorePoint {
  String nombre;
  String id;
  LatLng point;
}
