import 'package:latlong2/latlong.dart';

class Radio {
  Radio({
    required this.city,
    required this.website,
    required this.logoFileName,
    required this.streamlink,
    required this.position,
    required this.name,
  });

  final String city;
  final String website;
  final String logoFileName;
  final String streamlink;
  final LatLng position;
  final String name;
}
