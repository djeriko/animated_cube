import 'package:flutter/material.dart';
import 'dart:math' as math;

class CubicApp extends StatefulWidget {
  @override
  _CubicAppState createState() => _CubicAppState();
}

class _CubicAppState extends State<CubicApp>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation animation;
  static const double height = 200.0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: math.pi / 2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut),
    );
  }

  void onTap() {
    _animationController.value == 0
        ? _animationController.animateTo(1.0)
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
                // Red Box
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(
                      (math.cos(animation.value) * (height / 2)),
                      0.0,
                      (-(height / 2) * math.sin(animation.value)),
                    )
                    ..rotateY(-(math.pi / 2) + animation.value),
                  child: Container(
                    child: Center(
                        child: GestureDetector(
                      child: redBox,
                      onTap: onTap,
                    )),
                  ),
                ),

                // Green Box
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(
                      -(height / 2) * math.sin(animation.value),
                      0.0,
                      -((height / 2) * math.cos(animation.value)),
                    )
                    ..rotateY(animation.value),
                  child: Container(
                    child: Center(
                        child: GestureDetector(
                      child: animation.value < (85 * math.pi / 180)
                          ? greenBox
                          : Container(),
                      onTap: onTap,
                    )),
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
