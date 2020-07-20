import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/constraint.dart';
import 'package:finance/controller/homeController.dart';
import 'package:finance/custom-widget/circleIcon.dart';
import 'package:finance/custom-widget/customButton.dart';
import 'package:finance/services/map_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:user_location/user_location.dart';
import 'package:latlong/latlong.dart';

class Map extends StatefulWidget {
  final Position position;
  Map({this.position});
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> markers = [];
  final HomeController h = Get.find<HomeController>();
  onTap() {}
  @override
  void initState() {
    super.initState();
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
      //onLocationUpdate: (LatLng pos) => print("onLocationUpdate ${pos.toString()}"),
      verbose: false,

      onTapFAB: () => onTap(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  addMarker(LatLng lng, String pickAddress) {
    h.setLocation(pickAddress);
    setState(() {
      markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: lng, // a latlng of where you want it
        builder: (ctx) => Row(
          children: [Icon(FeatherIcons.mapPin), Flexible(child: Text("You here"))],
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                CircleIcon(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(FeatherIcons.x)),
                Text("My location"),
                Spacer(),
                CustomButton(
                  height: 35,
                  width: 80,
                  onPress: () {
                    Get.back();
                  },
                  tooltip: "Save",
                  iconColor: Colors.indigo,
                  icon: FeatherIcons.save,
                  childs: [Text("Save")],
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight(AppConstraint.appBarHeight)),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: FlutterMap(
          options: MapOptions(
              center: LatLng(widget.position.latitude, widget.position.longitude),
              zoom: 15.0,
              plugins: [
                UserLocationPlugin(),
              ],
              onTap: markers.length > 0
                  ? null
                  : (latlng) async {
                      print("you tap at $latlng");
                      await MapServices.getLocation(latlng)
                          .then((value) => addMarker(latlng, value));
                    }),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://api.tiles.mapbox.com/v4/"
                  "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoiaWdhdXJhYiIsImEiOiJjazFhOWlkN2QwYzA5M2RyNWFvenYzOTV0In0.lzjuSBZC6LcOy_oRENLKCg',
                'id': 'mapbox.streets',
              },
            ),
            MarkerLayerOptions(markers: markers),
            userLocationOptions
          ],
          mapController: mapController,
        ),
      ),
    );
  }
}