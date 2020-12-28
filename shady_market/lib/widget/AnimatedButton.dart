import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final Function onPressed;
  final List<Color> colors;
  final Color shadowColor;
  final Widget child;
  static const List<Color> scolors = [Colors.cyan, Colors.indigo];

  AnimatedButton({
    @required this.onPressed,
    this.colors: scolors,
    this.shadowColor: Colors.grey,
    @required this.child,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double scale;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 0.09,
        duration: Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - _animationController.value;
    return Transform.scale(
      scale: scale,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: widget.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter),
              boxShadow: [
                BoxShadow(
                  color: widget.shadowColor.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(2.5, 1), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(25)),
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          child: widget.child,
          duration: Duration(milliseconds: 300),
        ),
        onTapDown: (details) {
          _animationController.forward();
        },
        onTapUp: (details) {
          _animationController.reverse();
        },
      ),
    );
  }
}
