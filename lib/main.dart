import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

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
  
  static LatLng _initialPosition;
  static LatLng _lastMapPosition = _initialPosition;


  @override
  void initState() {
    super.initState();
    getUsersCurrentLocation();
  }

  void getUsersCurrentLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    checkForServiceAndPermission().then((value) {
      if (value = false) {
        _initialPosition = LatLng(122, -111);
      }
    });

    
    await location.getLocation().then((value) => 
      _initialPosition = LatLng(value.latitude, value.longitude)
    );
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


  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 20,
        ),
        mapType: MapType.hybrid,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
      )
    ]);
  }
}