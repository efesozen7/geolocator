import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

class LoginButton extends StatelessWidget {
  final Text title;
  final Image icon;
  final Color color;
  LoginButton({Key? key, required this.title, required this.icon, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        final provider = Provider.of<AuthProvider>(context, listen: false);
        provider.googleLogin();
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: color.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3))],
            color: color,
            borderRadius: BorderRadius.circular(14.0)),
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 2.5,
        child: Column(
          children: [
            icon,
            SizedBox(height: 10),
            title,
          ],
        ),
      ),
    );
  }
}
