import 'dart:ui';

import 'package:colorcatcher/color-catcher-game.dart';
import 'package:flutter/painting.dart';

import '../view.dart';

class ScoreDisplay {
  final ColorCatcherGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  int score;

  ScoreDisplay(this.game){
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
      if ((painter.text ?? '') != game.score.toString()) {
        painter.text = TextSpan(
          text: 'Score: ' + game.score.toString(),
          style: textStyle,
        );
      }

      painter.layout();

      position = Offset(
          (game.screenSize.width / 3) - painter.width,
          game.tileSize * .25,
        );
    }
  }
}