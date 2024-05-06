import 'dart:convert';
import 'dart:io';

import 'radio_station.dart';

void main() async {
  // File paths
  var inputFilePath = '../data.json';
  var outputFilePath = '../output_map.json';

  // Read JSON from file
  var inputFile = File(inputFilePath);
  var jsonData = await inputFile.readAsString();
  var data = jsonDecode(jsonData);

  // Assuming you want to process only the first document change
  final radios = data.map((e) {
    final doc = e[0][1][0]['documentChange']['document'];
    Map<String, dynamic> fields = {};
    doc['fields'].forEach((key, value) {
      fields[key] = value[value.keys.first];
    });
    return RadioStation(
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
  });

  // Extract fields

  // Create or update the RadioStation object

  // Write updated details to file
  var outputFile = File(outputFilePath);
  final radioMap = {for (final radio in radios) radio.name: radio};
  await outputFile.writeAsString(jsonEncode(radioMap));

  print('Data has been updated and saved to $outputFilePath');
}
