import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';
class BallScaleMultipleIndicator extends StatefulWidget{
  double width;
  Color color;
  BallScaleMultipleIndicator({this.width, this.color});
  @override
  State createState() {
          return BallScaleMultipleIndicatorState(width: this.width, color: this.color);
  }
}

class BallScaleMultipleIndicatorState extends State<BallScaleMultipleIndicator> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller;
  static int duration = 1300;
  double width;
  Color color;
  Size size;
  Paint paint;
  BallScaleMultipleIndicatorState({this.width, this.color});

  @override
  void initState() {
    this.width ??= 50;
    this.color ??= Colors.blue;
    this.size = Size(this.width, this.width);
    _initPaint();
    controller = AnimationController(
        duration:Duration(milliseconds: BallScaleMultipleIndicatorState.duration), vsync: this);
    final Animation curve =
    CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween<double>(begin: 0.0001, end: 0.999).animate(curve)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.repeat();
  }

  void _initPaint(){
    paint = Paint()
      ..style = PaintingStyle.fill
      ..color = this.color
      ..strokeWidth = 1;
  }

  @override
  Widget build(BuildContext context) {
       return CustomPaint(
            size: this.size,
            painter: BallScaleMultipleIndicatorPainter(
              this.animation,this.paint, this.color),);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

}

class BallScaleMultipleIndicatorPainter extends CustomPainter{
   Paint myPaint;
   Animation<double> animation;
   Color color;
   BallScaleMultipleIndicatorPainter(this.animation, this.myPaint, this.color);
  @override
  void paint(Canvas canvas, Size size) {
        double d = size.width;
        double r = d / 2;
        for(int i = 0; i < 3; i++){
             double tempR;
             double currentValue = pow(0.5, i) * animation.value;
             tempR = currentValue * r;
             Color tempColor = color.withOpacity(1 - currentValue);
             myPaint.color = tempColor;
             canvas.drawCircle(Offset(r, r), tempR, myPaint);

        }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
      return true;
  }
}