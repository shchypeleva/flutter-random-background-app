import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:random_background_app/main.dart';

void main(){

  test('RandomColor() unnamed constructor should create random colors', (){
    Color firstRandomColor = new RandomColor();
    Color secondRandomColor = new RandomColor();
    bool expected = false;
    bool actual = (firstRandomColor == secondRandomColor) ? true : false;

    //Theoretically, this test can fail if there will be two identical colors in a row, but the probability is to low and we will neglect this case.
    expect(actual, expected);
  });

  test('RandomColor.fromRGBO() named constructor should create random colors', (){
    Color firstRandomColor = new RandomColor.fromRGBO();
    Color secondRandomColor = new RandomColor.fromRGBO();
    bool expected = false;
    bool actual = (firstRandomColor == secondRandomColor) ? true : false;

    //Theoretically, this test can fail if there will be two identical colors in a row, but the probability is to low and we will neglect this case.
    expect(actual, expected);
  });

  test('RandomColor.fromARGB() named constructor should create random colors', (){
    Color firstRandomColor = new RandomColor.fromARGB();
    Color secondRandomColor = new RandomColor.fromARGB();
    bool expected = false;
    bool actual = (firstRandomColor == secondRandomColor) ? true : false;

    //Theoretically, this test can fail if there will be two identical colors in a row, but the probability is to low and we will neglect this case.
    expect(actual, expected);
  });

}