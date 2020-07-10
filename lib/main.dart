import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MySpinner());
}

class MySpinner extends StatefulWidget {
  @override
  _MySpinnerState createState() => _MySpinnerState();
}

class _MySpinnerState extends State<MySpinner> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      lowerBound: 0,
      upperBound: 360,
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SafeArea(
              child: Container(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget child) {
                    return CustomPaint(
                      painter: ThreeStripeSpinner(val: _animationController.value),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}

class ThreeStripeSpinner extends CustomPainter {
  ThreeStripeSpinner({@required this.val});
  final val;
  @override
  void paint(Canvas canvas, Size size) {

    final rectOuter = Rect.fromCircle(center: size.center(Offset.zero),radius: 30);
    final rectMid = Rect.fromCircle(center: size.center(Offset.zero),radius: 20);
    final rectInner = Rect.fromCircle(center: size.center(Offset.zero),radius: 10);

    final sweepAngleForArcs = 100 * math.pi / 180;
    double startAngleForArcs = val *2* math.pi / 180;
    final useCenter = false;
    final paint = Paint()
      ..color = Colors.cyanAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
        rectOuter, startAngleForArcs, sweepAngleForArcs, useCenter, paint);
    canvas.drawArc(
        rectMid, -startAngleForArcs, sweepAngleForArcs, useCenter, paint);
    canvas.drawArc(
        rectInner, startAngleForArcs, sweepAngleForArcs, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
