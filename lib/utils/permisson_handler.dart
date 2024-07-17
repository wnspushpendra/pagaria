import 'package:permission_handler/permission_handler.dart';

Future<bool> handlePermissions() async {
  var status = await Permission.storage.status;
  if (status.isDenied) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
       Permission.notification,
    ].request();
  }
  return true;
}
