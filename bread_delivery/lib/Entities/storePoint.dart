import 'package:latlong2/latlong.dart';

class StorePoints {
  final List<StorePoint> points;

  StorePoints(this.points);
}

class StorePoint {
  StorePoint(this.nombre, this.id, this.point);
  String nombre;
  int id;
  LatLng point;
}
