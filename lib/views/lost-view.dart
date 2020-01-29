import 'dart:ui';
import 'package:colorcatcher/color-catcher-game.dart';
import 'package:flutter/cupertino.dart';

class LostView {
  final ColorCatcherGame game;
  Rect rect;
  Paint rectPaint;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  TextPainter highScore;
  Offset highScorePosition;

  LostView(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 3) - (game.tileSize * 4),
      game.tileSize * 7,
      game.tileSize * 8,
    );

    rectPaint = Paint();
    rectPaint.color = Color(0xff9bc4cb);
    
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 30,
      fontWeight: FontWeight.bold
    );

    highScore = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
  }

  void render(Canvas c) {
    c.drawRect(rect, rectPaint);
    updateScore();
    updateHighScore();
    painter.paint(c, position);
    highScore.paint(c, highScorePosition);
  }

  updateScore(){
    painter.text = TextSpan(
        text: 'Score: ' + game.score.toString(),
        style: textStyle,
      );
    painter.layout();
    position = Offset(
        (game.screenSize.width / 2) - (painter.width / 2),
        (game.screenSize.height * .2) - (painter.height / 2),
      );
  }

  updateHighScore(){
    int highscore = game.storage.getInt('highscore') ?? 0;
    highScore.text = TextSpan(
        text: 'HighScore: ' + highscore.toString(),
        style: textStyle,
      );
    highScore.layout();
    highScorePosition = Offset(
        (game.screenSize.width / 2) - (highScore.width / 2),
        (game.screenSize.height * .4) - (highScore.height / 2),
      );
  }

}