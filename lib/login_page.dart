import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator_flutter/login_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoginButton(icon: Image(image: AssetImage("assets/planet.png")), title: Text("Login here"), color: Colors.blueAccent),
          LoginButton(icon: Image(image: AssetImage("assets/moon.png")), title: Text("Logout here"), color: Colors.green)
        ],
      ),
    );
  }
}
