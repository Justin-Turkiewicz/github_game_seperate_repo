import 'dart:ui';
import 'package:flame/game.dart';
import 'package:github_game/level.dart';
import 'package:flutter/material.dart';

/*
  This class represents the game with a specified level
*/
class GitHubGame extends FlameGame {
  // The folder holding the animation assets
  static const String ANIMATION_FILE_PATH = "animations";

  // The size in pixels of each tile
  static final Vector2 TILE_SIZE = Vector2.all(32.0);

  // Reference to the loaded level
  late final Level level;

  // The file path to the tile map
  late final String _mapPath;

  GitHubGame(this._mapPath);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(level = Level(_mapPath, Position(5, 5)));
  }
}
