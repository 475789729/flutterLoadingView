import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';
class BallSpinFadeLoaderIndicator extends StatefulWidget{
  double width;
  Color color;
  BallSpinFadeLoaderIndicator({this.width, this.color});
  @override
  State createState() {
       return BallSpinFadeLoaderIndicatorState(width: this.width, color: this.color);
  }
}

class BallSpinFadeLoaderIndicatorState extends State<BallSpinFadeLoaderIndicator> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller;
  Size size;
  Paint paint;
  double width;
  Color color;
  List<double> dx = List<double>();
  List<double> dy = List<double>();
  double scale = 0.83;
  List<double> scaleList = List<double>();
  static const double p = 0.81;
  static const double litteR = 1 - p;
  static int duration = 1000;

  BallSpinFadeLoaderIndicatorState({this.width, this.color});
  @override
  void initState() {
    this.width ??= 45;
    this.color ??= Colors.blue;
    _initPaint();
    _initAnimation();
    size = Size(this.width, this.width);
    _initPosition();
    _initScaleList();
  }

  @override
  Widget build(BuildContext context) {
       return CustomPaint(
            size: this.size,
             painter: BallSpinFadeLoaderIndicatorPainter(this.animation, this.paint, this.dx, this.dy, this.scaleList),
       );
  }

  void _initPaint(){
    paint = Paint()
      ..style = PaintingStyle.fill
      ..color = this.color
      ..strokeWidth = 1;
  }

  void _initAnimation(){
    controller = AnimationController(
        duration: Duration(milliseconds: duration), vsync: this);
    animation = Tween<double>(begin: 0, end: 7.999).animate(controller)
      ..addListener(() {
        setState(() {

        });
      });
    controller.repeat();
  }

  void _initPosition(){
      dx.clear();
      dy.clear();
      //以小圆圆心连接起来的圆形的半径
      double r = this.width / 2 * p;
      //1
      dx.add(0);
      dy.add(-r);
      //2
      double degrees45 = 45 * (pi / 180);
      dx.add(cos(degrees45) * r);
      dy.add(-sin(degrees45) * r);
      //3
      dx.add(r);
      dy.add(0);
      //4
      dx.add(cos(degrees45) * r);
      dy.add(sin(degrees45) * r);
      //5
      dx.add(0);
      dy.add(r);
      //6
      dx.add(-cos(degrees45) * r);
      dy.add(sin(degrees45) * r);
      //7
      dx.add(-r);
      dy.add(0);
      //8
      dx.add(-cos(degrees45) * r);
      dy.add(-sin(degrees45) * r);
  }

   void _initScaleList(){
        scaleList.clear();

        scaleList.add(1);
        scaleList.add(pow(scale, 1));
        scaleList.add(pow(scale, 2));
        scaleList.add(pow(scale, 3));
        scaleList.add(pow(scale, 4));
        scaleList.add(pow(scale, 3));
        scaleList.add(pow(scale, 2));
        scaleList.add(pow(scale, 1));
        /*
        scaleList.add(1);
        scaleList.add(0.85);
        scaleList.add(0.70);
        scaleList.add(0.55);
        scaleList.add(0.4);
        scaleList.add(0.55);
        scaleList.add(0.70);
        scaleList.add(0.85);
        */
   }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class BallSpinFadeLoaderIndicatorPainter extends CustomPainter{
   Paint myPaint;
   Animation<double> animation;
   List<double> dx;
   List<double> dy;
   List<double> scaleList;

   BallSpinFadeLoaderIndicatorPainter(this.animation, this.myPaint, this.dx, this.dy, this.scaleList);

  @override
  void paint(Canvas canvas, Size size) {
         int index = animation.value.floor();
         double centerX = size.width / 2;
         double centerY = size.height / 2;
         double littleR = BallSpinFadeLoaderIndicatorState.litteR * size.width / 2;
         for(int i = 0; i < 8; i++){
           double tempR;
           if(i >= index){
             tempR = this.scaleList[i - index] * littleR;
           }else{
             tempR = this.scaleList[8 - (index - i)] * littleR;
           }
           canvas.drawCircle(Offset(centerX + dx[i], centerY + dy[i]), tempR, myPaint);
         }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
        return true;
  }
}