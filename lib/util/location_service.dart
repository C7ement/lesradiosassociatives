import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationService {
  LocationService() {
    _init();
  }
  final StreamController<Position> _positionController =
      StreamController<Position>();

  Stream<Position> get positionStream => _positionController.stream;

  Future<void> _init() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _positionController.sink.add(position);

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      _positionController.sink.add(position);
    });
  }

  Future<Position> getPosition() async {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  dispose() {
    _positionController.close();
  }
}
