import 'dart:ui';

import 'package:colorcatcher/color-catcher-game.dart';
import 'package:flutter/painting.dart';

import '../view.dart';

class ColorTimer {
  final ColorCatcherGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  double time;
  double currentTime;
  
  ColorTimer(this.game) {
    time = 5;

    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 30,
    );

    position = Offset.zero;
  }

  void render(Canvas canvas){
    painter.paint(canvas, position);
  }

  void update(double t){
    if(game.activeView == View.playing){
      painter.text = TextSpan(
        text: currentTime.toStringAsFixed(1),
        style: textStyle,
      );
      painter.layout();

      position = Offset(
        game.screenSize.width - (game.tileSize * .25) - painter.width,
        game.tileSize * .25,
      );
      currentTime = currentTime - .5 * t;
      if(currentTime < 0) game.activeView = View.lost;
    }
  }
}