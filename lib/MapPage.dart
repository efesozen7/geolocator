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
  Circle circle = Circle(circleId: CircleId(""));
  Location _locationTracker = new Location();

  Geoflutterfire geo = Geoflutterfire();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static final CameraPosition initialLocation = CameraPosition(target: LatLng(41.004391, 29.055446), zoom: 14.45);

  void getCurrentLocation() async {
    try {
      var location = await _locationTracker.getLocation();
      updateCircle(location);
      GeoFirePoint point = geo.point(latitude: location.latitude!, longitude: location.longitude!);
      fireStore.collection('locations').add({'location': point.data, 'userId': 'nothing'});
      _locationTracker.onLocationChanged.listen((newLocationData) {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(target: LatLng(newLocationData.latitude!, newLocationData.longitude!), zoom: 18, tilt: 0, bearing: 192.83349),
        ));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateCircle(LocationData loc) {
    LatLng latlng = LatLng(loc.latitude!, loc.longitude!);
    this.setState(() {
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
        initialCameraPosition: initialLocation,
        circles: Set.of([circle]),
        onMapCreated: (GoogleMapController cntrl) {
          controller = cntrl;
        },
        myLocationEnabled: true,
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
