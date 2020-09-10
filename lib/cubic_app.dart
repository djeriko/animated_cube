import 'package:flutter/material.dart';
import 'dart:math' as math;

class CubicApp extends StatefulWidget {
  @override
  _CubicAppState createState() => _CubicAppState();
}

class _CubicAppState extends State<CubicApp>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  static const double maxSlide = 200.0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  void onTap() {
    _animationController.value == 0
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    var redBox = CubicSide(color: Colors.red);
    var greenBox = CubicSide(color: Colors.green);
    var blueBox = CubicSide(color: Colors.blue);
    return Container(
      child: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                // Red cube
                Transform.translate(
                  offset: Offset(-maxSlide * _animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi / 2 * _animationController.value),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: redBox,
                      onTap: onTap,
                    ),
                  ),
                ),

                // Green cube
                Transform.translate(
                  offset:
                      Offset(maxSlide * (_animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - _animationController.value)),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: greenBox,
                      onTap: onTap,
                    ),
                  ),
                ),

                // Blue cube
                Transform.translate(
                  offset: Offset(maxSlide * _animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi / 2 * _animationController.value),
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      child: blueBox,
                      onTap: onTap,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CubicSide extends StatelessWidget {
  final Color color;

  const CubicSide({Key key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: color,
    );
  }
}
