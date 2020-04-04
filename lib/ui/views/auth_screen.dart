import 'package:easy_ascent/ui/widgets/auth_card.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  final Color mainColor = Color(0xffCEE8D6);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/mountain.jpeg",
              fit: BoxFit.fitWidth,
            ),
            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.25,
              ),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(55.0),
                ),
              ),
              width: size.width,
              height: size.height * 0.75,
              padding: EdgeInsets.all(
                12.0,
              ),
              child: AuthCard(),
            ),
          ],
        ),
      ),
    );
  }
}
