import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Models/customer_branch.dart';

class ViewTodaysRoute extends StatefulWidget {
  List<CustomerBranch> routeBranches;
  ViewTodaysRoute({required this.routeBranches});
  @override
  State<ViewTodaysRoute> createState() => ViewTodaysRouteState();
}

class ViewTodaysRouteState extends State<ViewTodaysRoute> {
  Set<Marker> markers = {};
  List<LatLng> points = [];
  bool boolcheck = false;
  Completer<GoogleMapController> _controller = Completer();

  @override
  initState() {
    print(widget.routeBranches.length);
    for (int i = 0; i < widget.routeBranches.length; i++) {
      points.add(LatLng(double.parse(widget.routeBranches[i].latitude!),
          double.parse(widget.routeBranches[i].longitude!)));
      var my_icon = BitmapDescriptor.defaultMarker;
      if (i == 0) {
        my_icon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      } else if (i == widget.routeBranches.length - 1) {
        my_icon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
      }

      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        infoWindow: InfoWindow(title: widget.routeBranches[i].branch_Name),
        icon: my_icon,
        position: LatLng(double.parse(widget.routeBranches[i].latitude!),
            double.parse(widget.routeBranches[i].longitude!)),
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location Service are disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission are permanently denied");
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<void> _goToTheLake() async {
    Position position = await _determinePosition();
    String latitude = position.latitude.toStringAsFixed(6);
    String longitude = position.longitude.toStringAsFixed(6);
    //print("Marker Length: " + markers.length.toString());
    markers.removeWhere((element) => element.markerId.value == "99");
    //print("Marker Removed?: " + markers.length.toString());
    markers.add(Marker(
      markerId: const MarkerId("99"),
      infoWindow: const InfoWindow(title: "Current Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      position: LatLng(double.parse(latitude), double.parse(longitude)),
    ));
    //print("Marker Length: " + markers.length.toString());
    setState(() {});
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    )));
  }
}
