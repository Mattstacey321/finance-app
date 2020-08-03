import 'package:geolocator/geolocator.dart';

class MapServices {
  static Future<String> getAddressLocation({double latitude, double longitude}) async {
    try {
      if (latitude == null && longitude == null) {
        return "Can not get location";
      }else{
        List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(latitude, longitude);
      String yourLocation = placemark[0].subThoroughfare +
          ', ' +
          placemark[0].thoroughfare +
          ', ' +
          placemark[0].subAdministrativeArea;
      //print(placemark[0].subAdministrativeArea);
      return yourLocation;
      }
    } catch (e) {
      return "Can not get location";
    }
  }

  static Future<Map<dynamic, dynamic>> getCurrentLocation() async {
    Position position =
        await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromPosition(position);
    String yourLocation = placemark[0].subThoroughfare +
        ' ,' +
        placemark[0].thoroughfare +
        ' ,' +
        placemark[0].subAdministrativeArea;
    return {"position": position.toJson(), "address": yourLocation};
  }

  static Future getLocation() async {
    Position position =
        await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return {"latitude": position.latitude, "longitude": position.longitude};
  }
}
