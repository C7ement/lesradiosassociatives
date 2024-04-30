import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

extension LatLngExtension on LatLng {
  double distanceTo(LatLng other) {
    return Geolocator.distanceBetween(
      latitude,
      longitude,
      other.latitude,
      other.longitude,
    );
  }
}
