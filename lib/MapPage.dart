import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator_flutter/auth.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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
      body: Center(
        child: Container(
          height: 50,
          width: 50,
          color: Colors.red,
        ),
      ),
    );
  }
}
