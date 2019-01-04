import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
class BallScaleIndicator extends StatefulWidget{
  double width;
  Color color;
  BallScaleIndicator({this.width, this.color});
  @override
  State createState() {
     return BallScaleIndicatorState(width : this.width, color : this.color);
  }
}

class BallScaleIndicatorState extends State<BallScaleIndicator> with SingleTickerProviderStateMixin{
  double width;
  Color color;
  Size size;
  Paint paint;
  Animation<double> animation;
  AnimationController controller;
  static int duration = 1000;
  BallScaleIndicatorState({this.width, this.color});

  @override
  void initState() {
    this.width ??= 50;
    this.color ??= Colors.blue;
    this.size = Size(this.width, this.width);
    _initPaint();
    controller = AnimationController(
        duration:Duration(milliseconds: BallScaleIndicatorState.duration), vsync: this);
    final Animation curve =
    CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation = Tween<double>(begin: 0.0, end: 1).animate(curve)
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

        return Opacity(
          child: new CustomPaint(painter: new BallScaleIndicatorPainter(this.animation, this.paint),size: this.size,),
          opacity: 1 - this.animation.value,
        );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

}


class BallScaleIndicatorPainter extends CustomPainter{
  Animation<double> animation;
  Paint myPaint;
  BallScaleIndicatorPainter(this.animation, this.myPaint);
  @override
  void paint(Canvas canvas, Size size) {
    //直径
    double d = size.width;
    //半径
    double r = d / 2;
    double tempR = r * this.animation.value;
    canvas.drawCircle(Offset(r, r), tempR, myPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
     return true;
  }
}