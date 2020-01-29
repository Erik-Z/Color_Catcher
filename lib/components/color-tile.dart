import 'dart:ui';

import '../color-catcher-game.dart';
import '../view.dart';

class ColorTile{
  final ColorCatcherGame game;
  Rect tileRect;
  Paint tileColor;
  final double x;
  final double y;


  ColorTile(this.game, this.x, this.y){
    tileRect = Rect.fromLTWH(x, y, game.tileSize * 2, game.tileSize * 2);
    tileColor = Paint();
    tileColor.color = Color(0xff000000);
  }

  void setColor(int color){
    tileColor.color = Color(color);
  }

  void render(Canvas canvas){
    canvas.drawRect(tileRect, tileColor);
  }

  void onTapDown(){
    if(game.correctColor == tileColor.color.value){
      if (game.timer.time > 0.6){
        game.timer.time -= .5;
      } else if(game.timer.time < 0.6 && game.timer.time < 0.3) {
        game.timer.time -= .1;
      }
      game.timer.currentTime = game.timer.time;
      game.score += 1;
      if(game.score > (game.storage.getInt('highscore') ?? 0)){
        game.storage.setInt('highscore', game.score);
      }
      game.randomize();
    } else {
      game.activeView = View.lost;
    }
  }
}