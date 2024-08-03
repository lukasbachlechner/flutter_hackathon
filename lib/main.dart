import 'package:flutter/material.dart' hide PointerMoveEvent;
import 'package:flutter_hackathon/app.dart';
import 'package:flutter_hackathon/game_provider.dart';
import 'package:flutter_hackathon/models/game.model.dart';
import 'package:flutter_hackathon/widgets/game_app_bar.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameController(Game()),
      child: MaterialApp(
        theme: ThemeData(),
        home: Scaffold(
          body: const BattleshipApp(),
          appBar: AppBar(
            title: const GameAppBar(),
          ),
        ),
      ),
    ),
  );
}
