import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constants.dart';

class DrawerHeaderClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Offset circleCenter =
        Offset(size.width / 2, size.height - Constants.AVATAR_RADIUS);

    Offset topLeft = Offset(0, 0);
    Offset bottomLeft = Offset(0, size.height * 0.7);
    Offset topRight = Offset(size.width, 0);
    Offset bottomRight = Offset(size.width, size.height * 0.7);

    Offset leftCurveControlPoint =
        Offset(circleCenter.dx * 0.5, size.height - Constants.AVATAR_RADIUS);
    Offset rightCurveControlPoint =
        Offset(circleCenter.dx * 1.6, size.height - Constants.AVATAR_RADIUS);

    final arcStartAngle = 180 / 180 * pi;
    final avatarLeftPointX =
        circleCenter.dx + Constants.AVATAR_RADIUS * cos(arcStartAngle);
    final avatarLeftPointY =
        circleCenter.dy + Constants.AVATAR_RADIUS * sin(arcStartAngle);
    Offset avatarLeftPoint =
        Offset(avatarLeftPointX, avatarLeftPointY); // the left point of the arc

    final arcEndAngle = 0 / 180 * pi;
    final avatarRightPointX =
        circleCenter.dx + Constants.AVATAR_RADIUS * cos(arcEndAngle);
    final avatarRightPointY =
        circleCenter.dy + Constants.AVATAR_RADIUS * sin(arcEndAngle);
    Offset avatarRightPoint = Offset(
        avatarRightPointX, avatarRightPointY); // the right point of the arc

    Path path = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..quadraticBezierTo(leftCurveControlPoint.dx, leftCurveControlPoint.dy,
          avatarLeftPoint.dx, avatarLeftPoint.dy)
      ..arcToPoint(avatarRightPoint,
          radius: Radius.circular(Constants.AVATAR_RADIUS))
      ..quadraticBezierTo(rightCurveControlPoint.dx, rightCurveControlPoint.dy,
          bottomRight.dx, bottomRight.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
