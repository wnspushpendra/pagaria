import 'package:location/location.dart';


Future<LocationData?> checkLocationPermission() async {
  var serviceEnabled = await Location().serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await Location().requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  if (await Location().hasPermission() == PermissionStatus.denied) {
    await Location().requestPermission();
    if (Location().requestPermission() != PermissionStatus.granted) {
      return null;
    }
  }

  var  locationData = await Location().getLocation();
  return locationData;
}



