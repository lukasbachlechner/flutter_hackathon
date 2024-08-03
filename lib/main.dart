import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants/constants.dart';

import 'components/field_component.dart';

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

class BattleshipGame extends FlameGame {
  BattleshipGame();

  @override
  void onLoad() {
    // add(AlignComponent(
    //   child: TextComponent(text: 'Battleships', position: Vector2.zero()),
    //   alignment: Anchor.center,
    // ));

    for (var i = 0; i < boardSideResolution; i++) {
      for (var j = 0; j < boardSideResolution; j++) {
        add(Field(
          position: Vector2(i * gameWidth / boardSideResolution,
              j * gameWidth / boardSideResolution),
          size: Vector2(
              gameWidth / boardSideResolution, gameWidth / boardSideResolution),
          fieldData: 'data',
        ));
      }
    }

    // add(Quadrant(
    //   position: Vector2(100, 100),
    //   size: Vector2(100, 100),
    //   fieldData: 'data',
    // ));
  }
}
