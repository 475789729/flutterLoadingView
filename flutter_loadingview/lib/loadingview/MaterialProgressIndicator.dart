import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';
class MaterialProgressIndicator extends StatefulWidget{
  double width;
  Color color;
  double strokeWidth;
  MaterialProgressIndicator({this.width, this.color, this.strokeWidth});
  @override
  State createState() {
     return MaterialProgressIndicatorState(width: this.width, color: this.color, strokeWidth: this.strokeWidth);
  }
}
class MaterialProgressIndicatorState extends State<MaterialProgressIndicator> with SingleTickerProviderStateMixin{
  double width;
  Color color;
  double strokeWidth;
  Size size;
  Paint paint;
  Animation<double> animation;
  AnimationController controller;

  static const int durationTotal = 28000000;
  static const int angleTimeRangeFromShortToLong = 240;
  static const int angleRangeShort = 30;
  static const int angleRangeLong = 270;
  static const double beginAngle = 0;
  static const double endAngle = 7200000;
  MaterialProgressIndicatorState({this.width, this.color, this.strokeWidth});
  @override
  void initState() {
    this.width ??= 40;
    this.color ??= Colors.blue;
    this.strokeWidth ??= 5;
    size = Size(this.width, this.width);
    _initPaint();
    _initAnimation();
  }

  void _initPaint(){
    paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = this.color
      ..strokeWidth = this.strokeWidth;
  }
  void _initAnimation(){

    controller = AnimationController(
        duration: Duration(milliseconds: durationTotal), vsync: this);
    animation = Tween<double>(begin: beginAngle, end: endAngle).animate(controller)
      ..addListener(() {
        setState(() {

        });
      });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
       return CustomPaint(size: this.size,
                    painter: MaterialProgressIndicatorPainter(this.animation, this.paint, this.width));
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class MaterialProgressIndicatorPainter extends CustomPainter{
  Animation<double> animation;
  Paint myPaint;
  double width;
  Rect rect;
  MaterialProgressIndicatorPainter(Animation<double> animation, Paint myPaint, double width){
      this.animation = animation;
      this.myPaint = myPaint;
      this.width = width;
      this.rect = Rect.fromLTRB(0, 0, width, width);
  }
  @override
  void paint(Canvas canvas, Size size) {
      int timesShortToLongToShort = (this.animation.value / (MaterialProgressIndicatorState.angleTimeRangeFromShortToLong * 2)).floor();
      int qian = MaterialProgressIndicatorState.angleRangeShort + this.animation.value.floor();
      qian += timesShortToLongToShort * (MaterialProgressIndicatorState.angleRangeLong - MaterialProgressIndicatorState.angleRangeShort);
      int yushu = (this.animation.value).floor() % (MaterialProgressIndicatorState.angleTimeRangeFromShortToLong * 2);
      int hou;
      if(yushu < MaterialProgressIndicatorState.angleTimeRangeFromShortToLong){
        hou = qian - MaterialProgressIndicatorState.angleRangeShort;
        double temp = yushu / MaterialProgressIndicatorState.angleTimeRangeFromShortToLong;
        double temp2 = temp * (MaterialProgressIndicatorState.angleRangeLong - MaterialProgressIndicatorState.angleRangeShort);
        qian += temp2.floor();
      }else{
        qian += (MaterialProgressIndicatorState.angleRangeLong - MaterialProgressIndicatorState.angleRangeShort);
        hou = qian - MaterialProgressIndicatorState.angleRangeLong;
        double temp = (yushu - MaterialProgressIndicatorState.angleTimeRangeFromShortToLong) / MaterialProgressIndicatorState.angleTimeRangeFromShortToLong * (MaterialProgressIndicatorState.angleRangeLong - MaterialProgressIndicatorState.angleRangeShort);
        hou += temp.floor();
      }

      canvas.drawArc(this.rect, qian * (pi / 180), (hou - qian) * (pi / 180), false, myPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
      return true;
  }
}