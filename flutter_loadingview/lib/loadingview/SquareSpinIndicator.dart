import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';
class SquareSpinIndicator extends StatefulWidget{
  double width;
  Color color;

  SquareSpinIndicator({this.width, this.color});
  @override
  State createState() {
          return SquareSpinIndicatorState(width: this.width, color: this.color);
  }
}

class SquareSpinIndicatorState extends State<SquareSpinIndicator> with SingleTickerProviderStateMixin{
  double width;
  Color color;
  Size size;
  static int duration = 1300;
  Animation<double> animation;
  AnimationController controller;
  Paint paint;

  SquareSpinIndicatorState({this.width, this.color});
  @override
  void initState() {
    this.width ??= 30;
    this.color ??= Colors.blue;
    size = Size(this.width, this.width);
    _initAnimation();
    _initPaint();
  }
  void _initAnimation(){
    controller = AnimationController(
        duration: Duration(milliseconds: duration), vsync: this);
    animation = Tween<double>(begin: 0, end: 360).animate(controller)
      ..addListener(() {
        setState(() {

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
    Matrix4 matrix4;
    if(animation.value < 180){
      double angle = animation.value * (pi / 180);
      matrix4 = Matrix4.rotationY(angle);
    }else{
      double angle = (animation.value - 180) * (pi / 180);
      matrix4 = Matrix4.rotationX(angle);
    }
     return Transform(
          child: CustomPaint(painter: SquareSpinIndicatorPainter(this.paint),
            size: this.size,),
         transform : matrix4,
           origin: Offset(this.width / 2, this.width / 2),
     );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }


}
class SquareSpinIndicatorPainter extends CustomPainter{
   Paint myPaint;
   SquareSpinIndicatorPainter(this.myPaint);
  @override
  void paint(Canvas canvas, Size size) {
      canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), myPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
     return true;
  }
}
