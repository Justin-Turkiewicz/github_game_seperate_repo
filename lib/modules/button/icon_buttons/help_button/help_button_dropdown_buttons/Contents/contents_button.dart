import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_game/modules/button/icon_buttons/model/dropdown_button.dart';
import '../../../abstract/positional_values.dart';
import 'contents_popUp.dart';

class ContentsButton extends DropDownButton{
  ContentsButton({required String text, style, box, positional}) : super(text: text, style: style, box: box, positional: positional);
  static final data = ContentsPopUp(text: 'test', box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
      positional: Vector2(100,
          PositionalValues.nextY(0.0)));

  @override
  bool onTapDown(TapDownInfo e){
    try{
      print("Contents Button Tapped");
      !contains(data) ? add(data) : remove(data);
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
}