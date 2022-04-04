import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Models/customer_branch.dart';

class RouteMapScreen extends StatefulWidget {
  List<CustomerBranch> locations;
  RouteMapScreen({required this.locations});
  @override
  State<RouteMapScreen> createState() => RouteMapScreenState();
}

class RouteMapScreenState extends State<RouteMapScreen> {
  Set<Marker> markers = {};
  List<LatLng> points = [];
  double southWestLatitude = 0;
  double southWestLongitude = 0;
  double northEastLatitude = 0;
  double northEastLongitude = 0;
  Completer<GoogleMapController> _controller = Completer();

  @override
  initState() {
    // print(widget.locations.length);

    for (int i = 0; i < widget.locations.length; i++) {
      points.add(LatLng(double.parse(widget.locations[i].latitude!),
          double.parse(widget.locations[i].longitude!)));
      var my_icon = BitmapDescriptor.defaultMarker;
      if (i == 0) {
        my_icon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      } else if (i == widget.locations.length - 1) {
        my_icon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
      }

      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        infoWindow: InfoWindow(title: widget.locations[i].branch_Name),
        icon: my_icon,
        position: LatLng(double.parse(widget.locations[i].latitude!),
            double.parse(widget.locations[i].longitude!)),
      ));
    }
    // Calculating to check that the position relative
    // to the frame, and pan & zoom the camera accordingly.
    double miny = (points[0].latitude <= points[points.length - 1].latitude)
        ? points[0].latitude
        : points[points.length - 1].latitude;
    double minx = (points[0].longitude <= points[points.length - 1].longitude)
        ? points[0].longitude
        : points[points.length - 1].longitude;
    double maxy = (points[0].latitude <= points[points.length - 1].latitude)
        ? points[points.length - 1].latitude
        : points[0].latitude;
    double maxx = (points[0].longitude <= points[points.length - 1].longitude)
        ? points[points.length - 1].longitude
        : points[0].longitude;

    southWestLatitude = miny;
    southWestLongitude = minx;

    northEastLatitude = maxy;
    northEastLongitude = maxx;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Maps")),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: markers,
              polylines: {
                Polyline(
                  polylineId: PolylineId('kPolyline'),
                  points: points,
                  width: 5,
                ),
              },
              initialCameraPosition: CameraPosition(
                target: points[0],
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          InkWell(
            onTap: printRoute,
            child: Container(
              color: MyColors.blue,
              width: MyScreen.getScreenWidth(context) * (490.9 / 490.9),
              height: MyScreen.getScreenHeight(context) * (80 / 1063.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.zoom_out_map_outlined,
                    color: MyColors.white,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'See entire route',
                    style: TextStyle(
                        color: MyColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MyScreen.getScreenHeight(context) * (25 / 1063.6)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> printRoute() async {
    //print(selectedShops);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(
      LatLngBounds(
        northeast: LatLng(northEastLatitude, northEastLongitude),
        southwest: LatLng(southWestLatitude, southWestLongitude),
      ),
      100.0,
    ));
  }
}
