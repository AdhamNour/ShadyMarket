import 'dart:math';

import 'package:flutter/material.dart';

class AuthScreenBackgroundAnimation extends StatefulWidget {
  final height, width;
  final Widget child;
  List<Color> usedColors;
  double rotatingDirection;
  AuthScreenBackgroundAnimation(
      {this.height,
      this.width,
      this.child,
      @required List<Color> colors,
      List<Color> secondaryColors,
      bool counterClockwise}) {
    if (counterClockwise == null) {
      rotatingDirection = 2 * pi;
      usedColors = colors;
    } else if (counterClockwise) {
      rotatingDirection = 2 * pi;
      usedColors = colors;
    } else {
      rotatingDirection = 0;
      if (secondaryColors != null) {
        usedColors = secondaryColors;
      }
    }
  }
  @override
  _AuthScreenBackgroundAnimationState createState() =>
      _AuthScreenBackgroundAnimationState();
}

class _AuthScreenBackgroundAnimationState
    extends State<AuthScreenBackgroundAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animatedAngle;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 10), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reset();
              animationController.forward();
            }
          })
          ..addListener(() {
            setState(() {});
          });

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animatedAngle = Tween<double>(
            begin: 2 * pi - widget.rotatingDirection,
            end: widget.rotatingDirection)
        .animate(CurvedAnimation(
            parent: animationController,
            curve: Curves.linear)); //I really don't know why
    final x1 = Alignment.topLeft.x * cos(animatedAngle.value) -
        Alignment.topLeft.y * sin(animatedAngle.value);
    final y1 = Alignment.topLeft.x * sin(animatedAngle.value) +
        Alignment.topLeft.y * cos(animatedAngle.value);
    final x2 = Alignment.bottomRight.x * cos(animatedAngle.value) -
        Alignment.bottomRight.y * sin(animatedAngle.value);
    final y2 = Alignment.bottomRight.x * sin(animatedAngle.value) +
        Alignment.bottomRight.y * cos(animatedAngle.value);

    return AnimatedContainer(
      height: widget.height,
      width: widget.width,
      child: widget.child,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment(x1, y1),
        end: Alignment(x2, y2),
        colors: widget.usedColors,
      )),
      duration: Duration(milliseconds: 300),
    );
  }
}
