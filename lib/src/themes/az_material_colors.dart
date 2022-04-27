import 'package:flutter/material.dart';

const Map<int, Color> greyColor = {
  50: Color.fromRGBO(84, 110, 122, .1),
  100: Color.fromRGBO(84, 110, 122, .2),
  200: Color.fromRGBO(84, 110, 122, .3),
  300: Color.fromRGBO(84, 110, 122, .4),
  400: Color.fromRGBO(84, 110, 122, .5),
  500: Color.fromRGBO(84, 110, 122, .6),
  600: Color.fromRGBO(84, 110, 122, .7),
  700: Color.fromRGBO(84, 110, 122, .8),
  800: Color.fromRGBO(84, 110, 122, .9),
  900: Color.fromRGBO(84, 110, 122, 1),
};

const Map<int, Color> orangeColor = {
  50: Color.fromRGBO(255, 138, 101, .1),
  100: Color.fromRGBO(255, 138, 101, .2),
  200: Color.fromRGBO(255, 138, 101, .3),
  300: Color.fromRGBO(255, 138, 101, .4),
  400: Color.fromRGBO(255, 138, 101, .5),
  500: Color.fromRGBO(255, 138, 101, .6),
  600: Color.fromRGBO(255, 138, 101, .7),
  700: Color.fromRGBO(255, 138, 101, .8),
  800: Color.fromRGBO(255, 138, 101, .9),
  900: Color.fromRGBO(255, 138, 101, 1),
};

const Map<int, Color> blueColor = {
  50: Color.fromRGBO(35, 150, 243, .1),
  100: Color.fromRGBO(35, 150, 243, .2),
  200: Color.fromRGBO(35, 150, 243, .3),
  300: Color.fromRGBO(35, 150, 243, .4),
  400: Color.fromRGBO(35, 150, 243, .5),
  500: Color.fromRGBO(35, 150, 243, .6),
  600: Color.fromRGBO(35, 150, 243, .7),
  700: Color.fromRGBO(35, 150, 243, .8),
  800: Color.fromRGBO(35, 150, 243, .9),
  900: Color.fromRGBO(35, 150, 243, 1),
};

const Map<int, Color> greenColor = {
  50: Color.fromRGBO(76, 175, 80, .1),
  100: Color.fromRGBO(76, 175, 80, .2),
  200: Color.fromRGBO(76, 175, 80, .3),
  300: Color.fromRGBO(76, 175, 80, .4),
  400: Color.fromRGBO(76, 175, 80, .5),
  500: Color.fromRGBO(76, 175, 80, .6),
  600: Color.fromRGBO(76, 175, 80, .7),
  700: Color.fromRGBO(76, 175, 80, .8),
  800: Color.fromRGBO(76, 175, 80, .9),
  900: Color.fromRGBO(76, 175, 80, 1),
};
const MaterialColor greyMaterialColor = MaterialColor(0xFF546E7A, greyColor);
const MaterialColor orangeMaterialColor =
    MaterialColor(0xFFFF8A65, orangeColor);
const MaterialColor blueMaterialColor = MaterialColor(0xFFFF0D47A1, blueColor);
const MaterialColor greenMaterialColor = MaterialColor(0xFF4CAF50, greenColor);

final Color? darkOrange = orangeColor[900];
final Color? darkGrey = greyColor[900];
final Color? blue = blueColor[900];
final Color? green = blueColor[900];
