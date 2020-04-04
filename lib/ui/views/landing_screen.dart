import 'package:easy_ascent/core/enums/enums.dart';
import 'package:easy_ascent/core/models/user.dart';
import 'package:easy_ascent/core/providers/authentication.dart';
import 'package:easy_ascent/ui/views/home_screen.dart';
import 'package:easy_ascent/ui/views/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  static const String routeName = "/landing";

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool loading = true;
  User user;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (ctx, auth, _) {
        AuthStatus _status = auth.authStatus;
        return _status == AuthStatus.Authenticated
            ? HomeScreen()
            : AuthScreen();
      },
    );
  }
}
