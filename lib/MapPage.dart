import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator_flutter/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController controller;
  late StreamSubscription _locationSubscription;
  Circle circle = Circle(circleId: CircleId(""));
  Location _locationTracker = new Location();

  Geoflutterfire geo = Geoflutterfire();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static final CameraPosition initialLocation = CameraPosition(target: LatLng(41.004391, 29.055446), zoom: 14.45);
  @override
  void initState() {
    _locationSubscription = _locationTracker.onLocationChanged.listen((event) {});
    super.initState();
  }

  void getCurrentLocation() async {
    try {
      var location = await _locationTracker.getLocation();
      print("location updated");
      updateCircle(location);
      GeoFirePoint point = geo.point(latitude: location.latitude!, longitude: location.longitude!);
      fireStore.collection('locations').add({'location': point.data, 'userId': 'nothing'});

      controller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(target: LatLng(location.latitude!, location.longitude!), zoom: 18, tilt: 0, bearing: 192.83349)));
      updateCircle(location);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateCircle(LocationData loc) {
    LatLng latlng = LatLng(loc.latitude!, loc.longitude!);
    this.setState(() {
      print("setState");
      circle = Circle(
          circleId: CircleId("car"),
          radius: loc.accuracy!,
          zIndex: 1,
          strokeColor: Colors.lightBlueAccent,
          center: latlng,
          fillColor: Colors.lightBlueAccent.shade200);
    });
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              final provider = Provider.of<AuthProvider>(context, listen: false);
              provider.googleLogout();
            },
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          "Map",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        zoomControlsEnabled: false,
        initialCameraPosition: initialLocation,
        circles: Set.of([circle]),
        onMapCreated: (GoogleMapController cntrl) {
          controller = (cntrl);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentLocation();
        },
        child: Icon(Icons.location_searching),
      ),
    );
  }
}
