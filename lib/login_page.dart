import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator_flutter/login_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log-in with Google"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoginButton(
                icon: Image(image: AssetImage("assets/planet.png")),
                title: Text(
                  "Login here",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}
