import 'package:finance/controller/taskController.dart';
import 'package:finance/services/map_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:user_location/user_location.dart';
import 'package:latlong/latlong.dart';
import 'homeController.dart';

class MapsController extends GetxController {
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> markers = [];
  HomeController h = Get.find<HomeController>();
  TaskController t = Get.find<TaskController>();

  Future addYourCurrentLocation(latlng) async {
    await MapServices.getAddressLocation(latitude: latlng.latitude, longitude: latlng.longitude)
        .then((value) => addMarker(latlng, value));
  }

  addMarker(LatLng lng, String pickAddress) {
    var pickLocation = {"latitude": lng.latitude, "longitude": lng.longitude};
    t.setLocation(pickAddress, pickLocation);
    markers.add(Marker(
      width: 80.0,
      height: 80.0,

      point: lng, // a latlng of where you want it
      builder: (ctx) => Icon(Icons.location_on, color: Colors.blue, size: 40),
    ));
  }
}
