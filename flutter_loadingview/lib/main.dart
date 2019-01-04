import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';
import 'loadingview/BallPulseIndicator.dart';
import 'loadingview/BallScaleIndicator.dart';
import 'loadingview/BallScaleMultipleIndicator.dart';
import 'loadingview/BallSpinFadeLoaderIndicator.dart';
import 'loadingview/SquareSpinIndicator.dart';
import 'loadingview/MaterialProgressIndicator.dart';
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        home: DemoPage()
    );
  }
}

class DemoPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.redAccent),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Center(
                      heightFactor: 5,
                      child: BallScaleMultipleIndicator(color: Colors.white),
                    )
                ),
                Expanded(
                    child: Center(
                      heightFactor: 5,
                      child: BallScaleIndicator(color: Colors.white),
                    )
                ),
                Expanded(
                    child: Center(
                      heightFactor: 5,
                      child: BallPulseIndicator(color:Colors.white),
                    )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    heightFactor: 5,
                    child: BallSpinFadeLoaderIndicator(color : Colors.white),
                  ),
                ),
                Expanded(
                  child: Center(
                    heightFactor: 5,
                    child: MaterialProgressIndicator(color: Colors.white,),
                  ),
                ),
                Expanded(
                  child: Center(
                    heightFactor: 5,
                    child: SquareSpinIndicator(color: Colors.white),
                  ),
                )
              ],
            )

          ],
        )
    );


  }
}
