import 'dart:ui';

import 'package:colorcatcher/color-catcher-game.dart';
import 'package:flame/sprite.dart';

import '../view.dart';

class PlayButton {
  final ColorCatcherGame game;
  Rect rect;
  Sprite sprite;

  PlayButton(this.game){
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
    sprite = Sprite('ui/PlayButton-01.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.activeView = View.playing;
    game.score = 0;
    game.randomize();
    game.timer.time = 5;
    game.timer.currentTime = game.timer.time;
  }
}