import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:latlong2/latlong.dart';

import 'models/radio.dart';

String extractFilenameFromUrl(String url) {
  var decodedUrl = Uri.decodeFull(url);
  var uri = Uri.parse(decodedUrl);
  var segments = uri.pathSegments;
  if (segments.isNotEmpty) {
    var filename = segments.last;
    if (filename.contains('?')) {
      filename = filename.substring(0, filename.indexOf('?'));
    }
    return filename;
  } else {
    return '';
  }
}

class Repository {
  Repository();

  Future<List<Radio>> getRadios() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    final jsonData = json.decode(jsonString);
    final documentChanges =
        jsonData.map((e) => e[0][1][0]['documentChange']['document']['fields']);
    final radios = documentChanges.map((e) {
      final logoUrl = e['logo']?['stringValue'] ?? '';
      var filename = extractFilenameFromUrl(logoUrl);
      return Radio(
        website: e['website']?['stringValue'] ?? '',
        city: e['city']?['stringValue'] ?? '',
        streamlink: e['streamlink']?['stringValue'] ?? '',
        logoFileName: filename,
        position: LatLng(
          e['lat']?['doubleValue'] ?? 0,
          e['lng']?['doubleValue'] ?? 0,
        ),
      );
    }).whereType<Radio>();
    return radios.toList() as List<Radio>;
  }
}
