import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/animations/animations_list.dart';
import 'package:flutter_hackathon/constants/constants.dart';

import 'animations/animations.dart';

void main() async {
  runApp(const GameWrapper());

  await Flame.device.fullScreen();
}

class GameWrapper extends StatelessWidget {
  const GameWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightBlue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: FittedBox(
              child: SizedBox(
                height: gameHeight,
                width: gameWidth,
                child: GameWidget(
                  game: BattleshipGame(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const boardSideResolution = 20;

class BattleshipGame extends FlameGame with HasGameRef {
  BattleshipGame();

  @override
  void onLoad() async {
    // add(AlignComponent(
    //   child: TextComponent(text: 'Battleships', position: Vector2.zero()),
    //   alignment: Anchor.center,
    // ));

    // for (var i = 0; i < boardSideResolution; i++) {
    //   for (var j = 0; j < boardSideResolution; j++) {
    //     add(Field(
    //       position: Vector2(i * gameWidth / boardSideResolution,
    //           j * gameWidth / boardSideResolution),
    //       size: Vector2(
    //           gameWidth / boardSideResolution, gameWidth / boardSideResolution),
    //       fieldData: 'data',
    //     ));
    //   }
    // }

    // add(
    //   await addAnimation(
    //     gameRef,
    //     Vector2.all(192.0),
    //     Vector2.all(192.0),
    //     animationsList.first,
    //   ),
    // );

    for (int i = 0; i < 10; i++) {
      final int randomX = Random().nextInt(1000);
      final int randomY = Random().nextInt(1000);

      add(
        await getAnimation(
          gameRef,
          Vector2(randomX.toDouble(), randomY.toDouble()),
          Vector2.all(192.0),
          animationsList.first,
        ),
      );

      await Future.delayed(const Duration(milliseconds: 100));
    }

    // add(
    //   await addAnimation(
    //     gameRef,
    //     Vector2(0, 0),
    //     Vector2.all(192.0),
    //     animationsList.first,
    //   ),
    // );
    // add(
    //   await addAnimation(
    //     gameRef,
    //     Vector2(200, 200),
    //     Vector2.all(192.0),
    //     animationsList.first,
    //   ),
    // );
    // add(
    //   await addAnimation(
    //     gameRef,
    //     Vector2(400, 400),
    //     Vector2.all(192.0),
    //     animationsList[3],
    //   ),
    // );
    // add(Quadrant(
    //   position: Vector2(100, 100),
    //   size: Vector2(100, 100),
    //   fieldData: 'data',
    // ));
  }
}
