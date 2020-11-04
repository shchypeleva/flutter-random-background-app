import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:random_background_app/main.dart';

void main(){

  test('Color(1).random() should create random colors', (){
    Color firstRandomColor = new Color(1).random();
    Color secondRandomColor = new Color(1).random();
    bool expected = false;
    bool actual = (firstRandomColor == secondRandomColor) ? true : false;

    //Theoretically, this test can fail if there will be two identical colors in a row, but the probability is to low and we will neglect this case.
    expect(actual, expected);
  });
}