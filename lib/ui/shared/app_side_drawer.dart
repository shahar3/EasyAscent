import 'package:easy_ascent/core/providers/authentication.dart';
import 'package:easy_ascent/ui/screens/home/home_screen.dart';
import 'package:easy_ascent/ui/screens/landing/landing_screen.dart';
import 'package:easy_ascent/ui/screens/settings/settings_screen.dart';
import 'package:easy_ascent/ui/widgets/drawer_header_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class AppSideDrawer extends StatelessWidget {
  final avatarRadius = 44.0;
  final circleAvatarSize = 72.0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double drawerWidth = screenSize.width * 0.7;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Container(
      width: drawerWidth,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  width: drawerWidth,
                  height: Constants.DRAWER_HEADER_HEIGHT,
                  child: ClipPath(
                    clipper: DrawerHeaderClipper(),
                    child: Image.asset(
                      "assets/images/mountain.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: drawerWidth / 2 - avatarRadius,
                  top: 204,
                  child: Container(
                    child: CircleAvatar(
                      child: Icon(
                        Icons.perm_identity,
                        size: circleAvatarSize,
                      ),
                      radius: avatarRadius,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              padding: EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text(authProvider.user.email),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routeName);
                      },
                      title: Text("Home"),
                      leading: Icon(
                        Icons.home,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SettingsScreen.routeName);
                      },
                      title: Text("Settings"),
                      leading: Icon(
                        Icons.settings,
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        await authProvider.signOut();
                        Navigator.of(context)
                            .pushReplacementNamed(LandingScreen.routeName);
                      },
                      title: Text("Sign out"),
                      leading: Icon(
                        Icons.exit_to_app,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
