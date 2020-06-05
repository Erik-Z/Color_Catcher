import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/painting.dart';

import '../color-catcher-game.dart';

class ColorDisplay {
  final ColorCatcherGame game;
  int colorValue;
  TextConfig config;
  String coloredText;
  Position coloredTextPosition;

  TextConfig shadow;
  ColorDisplay(this.game){
    config = TextConfig(fontSize: 60.0, color: Color(0xffffffff), fontFamily: 'lemonmilk');
    coloredText = 'Color';
    coloredTextPosition = Position(0,0);
    shadow = TextConfig(fontSize: 65.0, color: Color(0xff000000));
  }

  void setColor(int colorValue){
    config = TextConfig(fontSize: 48.0, color: Color(colorValue));
  }

  void setText(String text){
    coloredText = text;
  }

  void render(Canvas c) {
    config.render(c, coloredText, coloredTextPosition);
  }

  void update(double t){
    coloredTextPosition = Position((game.screenSize.width / 2) - (coloredText.length * 12),
    (game.screenSize.height * .10));
  }
}