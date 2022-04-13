import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Models/hourly_attendance.dart';

class MapScreen extends StatefulWidget {
  List<Hourly_Attendance> hourly_attendance;
  MapScreen({required this.hourly_attendance});
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Set<Marker> markers = {};
  List<LatLng> points = [];

  Completer<GoogleMapController> _controller = Completer();

  @override
  initState() {
    print(widget.hourly_attendance.length);
    for (int i = 0; i < widget.hourly_attendance.length; i++) {
      points.add(LatLng(double.parse(widget.hourly_attendance[i].latitude),
          double.parse(widget.hourly_attendance[i].longitude)));
      var my_icon = BitmapDescriptor.defaultMarker;
      if (i == 0) {
        my_icon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      } else if (i == widget.hourly_attendance.length - 1) {
        my_icon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
      }

      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        infoWindow: InfoWindow(title: widget.hourly_attendance[i].time),
        icon: my_icon,
        position: LatLng(double.parse(widget.hourly_attendance[i].latitude),
            double.parse(widget.hourly_attendance[i].longitude)),
      ));
      print("Marker Length: " + markers.length.toString());
    }
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
            onTap: _goToTheLake,
            child: Container(
              color: MyColors.blue,
              width: MyScreen.getScreenWidth(context) * (490.9 / 490.9),
              height: MyScreen.getScreenHeight(context) * (80 / 1063.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.my_location,
                    color: MyColors.white,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Current Location',
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

  Future<void> _goToTheLake() async {
    print("hello");
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: points[points.length - 1],
      zoom: 14.4746,
    )));
  }
}
