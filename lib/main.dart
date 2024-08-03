import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/layout.dart';
import 'package:flutter/material.dart';

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
      home: Scaffold(
        body: Center(
          child: GameWidget(
            game: BattleshipGame(),
          ),
        ),
      ),
    );
  }
}

class BattleshipGame extends FlameGame {
  BattleshipGame();

  @override
  void onLoad() {
    add(AlignComponent(
      child: TextComponent(text: 'Battleships', position: Vector2.zero()),
      alignment: Anchor.center,
    ));
  }
}
