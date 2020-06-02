import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dissertation MaaS Prototype',
      // home: Map()
      home: Scaffold(
        body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.77483, -122.41942),
          zoom: 12,
        ),
      ))
    );
  }
}

// class Map extends StatefulWidget {
//   @override
//   State<Map> createState() => MapState();
// }

// class MapState extends State<Map> {
//   Completer<GoogleMapController> _controller = Completer();

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(37.77483, -122.41942),
//           zoom: 12,
//         ),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ));
//   }
// }
  
