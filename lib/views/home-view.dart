import 'dart:ui';
import 'package:colorcatcher/color-catcher-game.dart';
import 'package:flame/sprite.dart';

class HomeView {
  final ColorCatcherGame game;
  Rect titleRect;
  Sprite titleSprite;

  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 4),
      game.tileSize * 7,
      game.tileSize * 4,
    );
    titleSprite = Sprite('branding/ColorCatcher-01.png');
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }
}