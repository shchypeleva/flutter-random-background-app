import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:random_background_app/main.dart';

void main(){

  test('Flutter Color should be converted to HEX String', (){
    Color flutterColor = Colors.white;
    String HEXColor = colorToHex(flutterColor);

    expect(HEXColor, '#ffffff');
  });

  test('Flutter Color should be converted to RGB String', (){
    Color flutterColor = Colors.white;
    String RGBColor = colorToRGB(flutterColor);

    expect(RGBColor, '255 255 255');
  });
}