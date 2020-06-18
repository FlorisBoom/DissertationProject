import 'dart:async';

import 'package:DissertationProject/planner.dart';
import 'package:DissertationProject/wallet.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';

LatLng _initialPosition;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  checkForServiceAndPermission().then((serviceAndPermissionGranted) {
    if (serviceAndPermissionGranted = true) {
      getUsersCurrentLocation().then((gotLocation) {
        if(gotLocation = true) {
          runApp(MyApp());
        }
      });
    }
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dissertation Project',
      home: Scaffold(
        body: Map()
      ),
    );
  }
}

class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14,
        ),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
      ),
      Positioned(
        bottom: 20,
        right: 165,
        child:
        FlatButton(
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => Planner())
            );
          },
          child: Icon(Icons.train, color: Colors.black, size: 30)
        )
      ),
      Positioned(
        bottom: 20,
        right: 10,
        child:  
        FlatButton(
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
          color: Colors.white,
          onPressed: () { _centerCamera(_controller); },
          child: Icon(Icons.center_focus_strong, color: Colors.black, size: 30),
        ),
      ),
      Positioned(
        bottom: 20,
        left: 10,
        child: 
        FlatButton(
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => Wallet())
            );
          },
          child: Icon(Icons.monetization_on, color: Colors.black, size: 30),
        ),
      )
    ]);
  }
}

Future<bool> getUsersCurrentLocation() async {
  Location location = new Location();
    
  await location.getLocation().then((value) => 
    _initialPosition = LatLng(value.latitude, value.longitude)
  );
  return Future.value(true);
}

Future<bool> checkForServiceAndPermission() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return Future.value(false);
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return Future.value(false);
    }
  }
  return Future.value(true);
} 

Future<void> _centerCamera(Completer _controller) async {
  final mapController = await _controller.future;
  mapController.animateCamera(CameraUpdate.newCameraPosition(
    CameraPosition(target: _initialPosition, zoom: 14)
  ));
}

