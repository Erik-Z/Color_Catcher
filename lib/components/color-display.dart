import 'dart:ui';
import 'package:flutter/painting.dart';

import '../color-catcher-game.dart';

class ColorDisplay {
  final ColorCatcherGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  String colorText;
  int colorValue;

  ColorDisplay(this.game){
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 75,
      fontWeight: FontWeight.bold
    );

    painter.text = TextSpan(
        text: 'Color',
        style: textStyle,
      );
    
    position = Offset.zero;
  }

  void setColor(int colorValue){
    textStyle = TextStyle(
      color: Color(colorValue),
      fontSize: 75,
      fontWeight: FontWeight.bold,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );
  }

  void setText(String text){
    painter.text = TextSpan(
        text: text,
        style: textStyle,
      );
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t){
    //Keep text centered
    painter.layout();
    position = Offset(
        (game.screenSize.width / 2) - (painter.width / 2),
        (game.screenSize.height * .20) - (painter.height),
      );
  }
}