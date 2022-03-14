import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Set<Marker> markers = {};
  List<LatLng> points = [];
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchContoller = TextEditingController();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final Marker _Marker1 = Marker(
    markerId: MarkerId('Marker1'),
    infoWindow: InfoWindow(title: '11:00'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    position: LatLng(37.418, -122.092),
  );

  static final Marker _Marker2 = Marker(
    markerId: MarkerId('Marker2'),
    infoWindow: InfoWindow(title: '12:00'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(37.42796133580664, -122.085749655962),
  );

  static final Marker _Marker3 = Marker(
    markerId: MarkerId('Marker3'),
    infoWindow: InfoWindow(title: '1:00'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(37.43296265331129, -122.08832357078792),
  );

  static final Marker _Marker4 = Marker(
    markerId: MarkerId('Marker4'),
    infoWindow: InfoWindow(title: '3:00'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(37.435, -122.092),
  );

  static const Polyline _kPolyline = Polyline(
    polylineId: PolylineId('kPolyline'),
    points: [],
    width: 5,
  );
  static const Polygon _kPolygon = Polygon(
      polygonId: PolygonId('kPolygon'),
      points: [
        LatLng(37.418, -122.092),
        LatLng(37.42796133580664, -122.085749655962),
        LatLng(37.43296265331129, -122.08832357078792),
        LatLng(37.435, -122.092),
      ],
      strokeWidth: 5,
      fillColor: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    points = [
      LatLng(37.418, -122.092),
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.43296265331129, -122.08832357078792),
      LatLng(37.435, -122.092),
    ];
    markers = {
      _Marker1,
      _Marker2,
      _Marker3,
      _Marker4,
    };
    // for (int i = 0;
    //     i < Database_Hourly_Attendance.hourly_attendance.length;
    //     i++) {
    // points.add(LatLng(
    //     double.parse(
    //         Database_Hourly_Attendance.hourly_attendance[i].latitude),
    //     double.parse(
    //         Database_Hourly_Attendance.hourly_attendance[i].longitude)));
    /*markers.add(Marker(
        markerId: MarkerId(i.toString()),
        infoWindow: InfoWindow(
            title: Database_Hourly_Attendance.hourly_attendance[i].time),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: LatLng(
            double.parse(
                Database_Hourly_Attendance.hourly_attendance[i].latitude),
            double.parse(
                Database_Hourly_Attendance.hourly_attendance[i].longitude)),
      ));*/
    //   print("Marker Length: " + markers.length.toString());
    // }

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
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: points[points.length - 1],
      zoom: 14.4746,
    )));
  }
}
