import 'package:flutter/cupertino.dart';

class MyColor{
  static MyColor instance = MyColor._internal();
  factory MyColor() => instance;
  MyColor._internal(){
    // todo
  }

  Color c218(){
    return Color.fromARGB(100, 218, 218, 218);
  }
}