import 'dart:convert';
import 'dart:io';

import 'radio_station.dart';

void main() async {
  // File paths
  var inputFilePath = '../data.json';
  var outputFilePath = '../output.json';

  // Read JSON from file
  var inputFile = File(inputFilePath);
  var jsonData = await inputFile.readAsString();
  var data = jsonDecode(jsonData);

  // Assuming you want to process only the first document change
  var documentChange = data[0][0][1][0]['documentChange']['document'];
  final keys = data.map((e) {
    print(e[0][1].length);
    return e[0][0];
  });
  print(keys);

  // Extract fields
  Map<String, dynamic> fields = {};
  documentChange['fields'].forEach((key, value) {
    fields[key] = value[value.keys
        .first]; // Assuming the value is always a map with a single key-value
  });

  // Create or update the RadioStation object
  RadioStation radio = RadioStation(
    name: fields['name'],
    city: fields['city'],
    team: fields['team'],
    zipcode: fields['zipcode'],
    lat: fields['lat'],
    lng: fields['lng'],
    website: fields['website'],
    logo: fields['logo'],
    status: fields['status'],
    streamlink: fields['streamlink'],
    slogan: fields['slogan'],
    geohash: fields['geohash'],
    fblink: fields['fblink'],
  );

  // Write updated details to file
  var outputFile = File(outputFilePath);
  await outputFile.writeAsString(jsonEncode(radio.toJson()));

  print('Data has been updated and saved to $outputFilePath');
}
