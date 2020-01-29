import 'dart:ui';
import 'dart:math';

import 'package:colorcatcher/components/color-display.dart';
import 'package:colorcatcher/components/color-tile.dart';
import 'package:colorcatcher/components/play-button.dart';
import 'package:colorcatcher/components/score-display.dart';
import 'package:colorcatcher/views/home-view.dart';
import 'package:colorcatcher/views/lost-view.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/timer.dart';
import 'view.dart';

class ColorCatcherGame extends Game{
  Size screenSize;
  double tileSize;
  int correctColor;
  int score;
  final SharedPreferences storage;
  
  Rect bgRect;
  Paint bgPaint;
  Random rnd;

  List<String> colorList;
  List<int> colorValueList;
  List<ColorTile> tileList;

  ColorTile tile1;
  ColorTile tile2;
  ColorTile tile3;
  ColorTile tile4;
  ColorTile tile5;
  ColorTile tile6;

  ColorDisplay colorDisplay;

  View activeView = View.home;
  PlayButton playButton;
  ColorTimer timer;
  ScoreDisplay scoreDisplay;
  HomeView homeView;
  LostView lostView;

  ColorCatcherGame(this.storage){
    initialize();
  }

  void initialize() async{
    score = 0;
    colorList = [
      'Blue', 'Green', 'Yellow', 
      'Red', 'Pink', 'Orange',
      'White', 'Black', 'Purple',
      'Brown', 'Beige', 'Lime',
      'Mint', 'Olive', 'Navy',
      'Cyan', 'Teal', 'Lavender',
      'Grey', 'Apricot'
    ];

    colorValueList = [
      //blue, green, yellow
      0xff4363d8, 0xff00ff00 , 0xffffff00,
      //red, pink, orange
      0xffff0000, 0xffffc0cb, 0xffff6600,
      //white, black, purple
      0xffffffff, 0xff000000, 0xff911eb4,
      //Brown, Beige, Lime
      0xff964B00, 0xfffffac8, 0xffbfef45,
      //Mint, Olive, Navy
      0xffaaffc3, 0xff808000, 0xff000075,

      0xff42d4f4, 0xff469990, 0xffe6beff,

      0xffa9a9a9, 0xffffd8b1,
    ];
    rnd = Random();

    resize(await Flame.util.initialDimensions());
    tile1 = ColorTile(this, tileSize * 0.5, (screenSize.height * .25));
    tile2 = ColorTile(this, tileSize * 3.5, (screenSize.height * .25));
    tile3 = ColorTile(this, tileSize * 6.5, (screenSize.height * .25));
    tile4 = ColorTile(this, tileSize * 0.5, (screenSize.height * .50));
    tile5 = ColorTile(this, tileSize * 3.5, (screenSize.height * .50));
    tile6 = ColorTile(this, tileSize * 6.5, (screenSize.height * .50));
    colorDisplay = ColorDisplay(this);
    tileList = [tile1, tile2, tile3, tile4, tile5, tile6];
    playButton = PlayButton(this);
    timer = ColorTimer(this);
    scoreDisplay = ScoreDisplay(this);

    homeView = HomeView(this);
    lostView = LostView(this);
  }

  @override
  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff696969);
    canvas.drawRect(bgRect, bgPaint);
    if(activeView == View.home) homeView.render(canvas);
    if(activeView == View.lost) lostView.render(canvas);

    if (activeView == View.playing) tileList.forEach((ColorTile tile) => tile.render(canvas));
    if (activeView == View.playing) colorDisplay.render(canvas);
    if (activeView == View.home || activeView == View.lost) playButton.render(canvas);
    if(activeView == View.playing) timer.render(canvas);
    if(activeView == View.playing) scoreDisplay.render(canvas);
  }

  @override
  void update(double t) {
    colorDisplay.update(t);
    timer.update(t);
    scoreDisplay.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d){
    if(activeView == View.playing){
      tileList.forEach((ColorTile tile) => {
        if(tile.tileRect.contains(d.globalPosition)){
          tile.onTapDown()
        }
      });
    }
    if(playButton.rect.contains(d.globalPosition)){
      playButton.onTapDown();
    }
  }

  void randomize(){
    int randomColor = rnd.nextInt(20);
    int randomValue = rnd.nextInt(20);
    correctColor = colorValueList[randomValue];
    colorDisplay.setColor(correctColor);
    colorDisplay.setText(colorList[randomColor]);

    int index = rnd.nextInt(6);
    tileList[index].setColor(correctColor);
    tileList = tileList.asMap().entries.map((entry) {
      int idx = entry.key;
      ColorTile tile = entry.value;
      if(idx != index){
        int randomTileColor;
        do {
          randomTileColor = rnd.nextInt(20);
        } while (randomTileColor == randomValue);
        tile.setColor(colorValueList[randomTileColor]);
      }
      return tile;
    }).toList();
  }
}