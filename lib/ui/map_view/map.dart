import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/constraint.dart';
import 'package:finance/controller/mapController.dart';
import 'package:finance/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:user_location/user_location.dart';

class MapView extends StatelessWidget {
  final double latitude;
  final double longitude;
  MapView({this.latitude, this.longitude});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapsController>(
        init: MapsController(),
        builder: (_) {
          var userLocationOptions = UserLocationOptions(
            context: context,
            mapController: _.mapController,
            markers: _.markers,
            zoomToCurrentLocationOnLoad: true,
            //onLocationUpdate: (ln) => mapController.move(ln, 1),
            //onLocationUpdate: (LatLng pos) => print("onLocationUpdate ${pos.toString()}"),
            //onTapFAB: () => _.onTap(),
          );
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
                    center: LatLng(latitude, longitude),
                    zoom: 15.0,
                    plugins: [UserLocationPlugin(), PopupMarkerPlugin()],
                    onLongPress:
                        _.markers.length > 1 ? null : (latlng) => _.addYourCurrentLocation(latlng)),
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
                  MarkerLayerOptions(markers: _.markers),
                  userLocationOptions
                ],
                mapController: _.mapController,
              ),
            ),
          );
        });
  }
}

/*class MapView extends StatefulWidget {
  final double latitude;
  final double longitude;
  MapView({this.latitude, this.longitude});
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapView> {
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> markers = [];
  HomeController h = Get.find<HomeController>();
  onTap() {}

  addMarker(LatLng lng, String pickAddress) {
    var pickLocation = {"latitude": lng.latitude, "longitude": lng.longitude};
    h.setLocation(pickAddress, pickLocation);
    setState(() {
      markers.add(Marker(
        width: 80.0,
        height: 80.0,

        point: lng, // a latlng of where you want it
        builder: (ctx) => Icon(Icons.location_on, color: Colors.blue, size: 40),
      ));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
      zoomToCurrentLocationOnLoad: true,
      //onLocationUpdate: (ln) => mapController.move(ln, 1),
      //onLocationUpdate: (LatLng pos) => print("onLocationUpdate ${pos.toString()}"),
      onTapFAB: () => onTap(),
    );
    return GetBuilder(
        builder: (_) => Scaffold(
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
                      center: LatLng(widget.latitude, widget.longitude),
                      zoom: 15.0,
                      plugins: [UserLocationPlugin(), PopupMarkerPlugin()],
                      onLongPress: markers.length > 0
                          ? null
                          : (latlng) async {
                              print("you tap at $latlng");
                              await MapServices.getAddressLocation(
                                      latitude: latlng.latitude, longitude: latlng.longitude)
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
            ));
  }
}*/
