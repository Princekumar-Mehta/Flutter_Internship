import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  Completer<GoogleMapController> _controller = Completer();

  @override
  initState() {
    print(widget.locations.length);
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
        ],
      ),
    );
  }
}
