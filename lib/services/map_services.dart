import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class MapServices {
  static Future getLocation(LatLng latlng) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(latlng.latitude, latlng.longitude);
    String yourLocation = placemark[0].subThoroughfare +
        ' ,' +
        placemark[0].thoroughfare +
        ' ,' +
        placemark[0].subAdministrativeArea;
    //print(placemark[0].subAdministrativeArea);
    return yourLocation;
  }
}
