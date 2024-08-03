import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide PointerMoveEvent;
import 'package:flutter_hackathon/constants/constants.dart';
import 'package:flutter_hackathon/game.dart';

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
          child: GameWidget(
            game: BattleshipGame(),
          ),
        ),
      ),
    );
  }
}
