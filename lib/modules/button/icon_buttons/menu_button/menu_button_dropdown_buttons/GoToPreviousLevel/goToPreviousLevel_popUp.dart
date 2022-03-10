import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
/// GoToPreviousLevelPopUp class -Justin
class GoToPreviousLevelPopUp extends TextBoxComponent {
  late final String text;
  late final style;
  late final box;
  late final positional;

  /// Constructor passes parameters to the TextBoxComponent class
  GoToPreviousLevelPopUp({required this.text, this.style, this.box, this.positional}) : super(text: text, textRenderer: style, boxConfig: box, position: positional);

  /// Boilerplate for drawing rectangle when associated Dropdown button is clicked.
  @override
  void drawBackground(Canvas c){
    Rect rect = Rect.fromLTWH(0, 0, 200, 500);
    final paint = Paint()
    //..color = Color(0xFF182c4f)
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(
          colors: [Color(0xFF2f62ba), Color(0xFF182c4f)]).createShader(rect);
    c.drawRect(
        rect,//rect.deflate(box.margins.right),//could be left,top,right or bottom
        paint);
  }
}