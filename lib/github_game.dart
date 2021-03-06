import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:github_game/level.dart';
import 'package:flame/input.dart';
import 'dart:convert';
import 'modules/buttons/in_level_buttons/icon_buttons/menu_button/menu_button.dart';
import 'modules/buttons/in_level_buttons/icon_buttons/help_button/help_button.dart';

/*
  This class represents the game with a specified level. Added HasTappables -Justin
*/
class GithubGame extends FlameGame with HasKeyboardHandlerComponents, HasTappables, HasHoverables{
  // The directory holding animation assets
  static const String ANIMATION_FILE_PATH = "animations";

  static const String LEVEL_DIRECTORY_PATH = "assets/levels";
  static const String LEVEL_PATH = "$LEVEL_DIRECTORY_PATH";
  
  // Directory for in_level_buttons sprites -Justin
  static const String BUTTON_SPRITES_FILE_PATH = "button_sprites";

  // Button sizes -Justin
  static const double BUTTON_SIZE = 50.0;

  // The size in pixels of each tile
  static final Vector2 TILE_SIZE = Vector2.all(48.0);

  // Reference to the loaded level
  late Level level;

  // The file path to the tile map-
  late String _mapPath;

  /// Returns the path to the map file.
  String get mapPath => _mapPath;

  set mapPath(String newPath){
    _mapPath = newPath;
  }

  //Instantiates overlay to handle adding menu to screen
  static ActiveOverlaysNotifier overlay = ActiveOverlaysNotifier();

  //Instantiates Menu Button and associated size -Justin
  static MenuButton menuButton = MenuButton();
  static final Vector2 MENUBUTTON_SIZE = Vector2.all(BUTTON_SIZE);

  //Instantiates Help Button and associated size -Justin
  static HelpButton helpButton = HelpButton();
  static final Vector2 HELPBUTTON_SIZE = Vector2.all(BUTTON_SIZE);

  //Instantiates screenWidth and screenHeight of game dimensions
  static int screenWidth = 0;
  static int screenHeight = 0;
  //Instantiates canvasWidth and canvasHeight of browser dimensions
  double canvasWidth = 0.0;
  double canvasHeight = 0.0;

  GithubGame(this._mapPath);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    String json = await rootBundle.loadString("$LEVEL_PATH/level_one/level.json");
    await add(level = Level.fromJson(jsonDecode(json)));

    /// First value is how many tiles fill the map in width. Second value
    /// is the width of a single tile. Multiplying them gets us the screenWidth. -Justin
    screenWidth = level.mapModule.map.width*level.mapModule.map.tileWidth;
    screenHeight = level.mapModule.map.height*level.mapModule.map.tileHeight;

    /// Sets canvas dimensions. Needed in update() method
    canvasWidth = canvasSize.x;
    canvasHeight = canvasSize.y;

    /// Adds level buttons if not on main menu screen. Will change if no
    /// main_menu level
    if(this._mapPath != 'main_menu.tmx') {
      /// Sets properties of buttons. -Justin
      menuButton
        ..sprite = await loadSprite('$BUTTON_SPRITES_FILE_PATH/home_grey.png')
        ..size = MENUBUTTON_SIZE
        ..position = Vector2((1/200)*canvasSize.x, (1/150)*canvasSize.y)
        ..positionType = PositionType.widget;
      helpButton
        ..sprite = await loadSprite('$BUTTON_SPRITES_FILE_PATH/help_grey.png')
        ..size = HELPBUTTON_SIZE
        ..position = Vector2((1/1.04)*canvasSize.x, (1/150)*canvasSize.y)
        ..positionType = PositionType.widget;
      /// Sets position of dropdown buttons. screenWidth and screenHeight needed for
      /// the dropdown buttons constructor
      helpButton.setDropDownButtons(
          screenWidth: canvasSize.x.toInt(), screenHeight: canvasSize.y.toInt());

      /// Await needed to load one component at a time otherwise they
      /// won't load on same screen. -Justin
      await addInLevelButtons();
    }
  }

  @override
  void update(double dt){
    super.update(dt);
    ///Changes position of buttons as size of browser changes
    double newCanvasWidth = canvasSize.x;
    double newCanvasHeight = canvasSize.y;
    if(newCanvasWidth != canvasWidth || newCanvasHeight != newCanvasHeight){
      canvasWidth = newCanvasWidth;
      canvasHeight = newCanvasHeight;
      menuButton.position = Vector2((1/200)*canvasSize.x, (1/150)*canvasSize.y);
      helpButton.position = Vector2((1/1.09)*canvasSize.x, (1/150)*canvasSize.y);
    }
  }
  /// Adds level buttons to the screen
Future<void> addInLevelButtons() async{
  await add(menuButton);
  await add(helpButton);
}
/// Handles changing the level map
Future<void> newLevel(Level newLevel) async{
    remove(this.level);
    this.level = newLevel;
    await add(this.level);
}

}

