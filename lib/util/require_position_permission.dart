import 'package:permission_handler/permission_handler.dart';

Future<bool> requirePositionPermission() async {
  if (await Permission.locationWhenInUse.isGranted) {
    return true;
  } else if (await Permission.locationWhenInUse.isPermanentlyDenied) {
    await openAppSettings();
    return Permission.locationWhenInUse.isGranted;
  } else {
    return Permission.locationWhenInUse.request().isGranted;
  }
}
