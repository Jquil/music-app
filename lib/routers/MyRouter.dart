import 'package:demo/page/BankMusicPage.dart';
import 'package:demo/page/HomePage.dart';
import 'package:demo/page/SearchListPage.dart';
import 'package:demo/page/SingerPage.dart';
import 'package:demo/page/SongSheetPage.dart';
import 'package:flutter/material.dart';

class MyRouter{

  static final String
    PAGE_HOME = "home",
    PAGE_BANKMUSIC  = "bankmusic",
    PAGE_SEARCHLIST = "searchlist",
    PAGE_SONGSHEET  = "songsheet",
    PAGE_SINGER     = "singer",
    PATH = "path",
    VIEW = "view";

  static final MyRouter instance = MyRouter._internal();

  factory MyRouter(){
    return instance;
  }

  MyRouter._internal(){
    // todo
  }

  // 路由表
  List<Map<String,dynamic>> routes(){
    return [
      {
        PATH:PAGE_HOME,
        VIEW:HomePage(),
      },
      {
        PATH:PAGE_BANKMUSIC,
        VIEW:BankMusicPage(),
      },
      {
        PATH:PAGE_SEARCHLIST,
        VIEW:SearchListPage()
      },
      {
        PATH:PAGE_SONGSHEET,
        VIEW:SongSheetPage()
      },
      {
        PATH:PAGE_SINGER,
        VIEW:SingerPage()
      }
    ];
  }

  // 遍历
  Map<String,Widget Function(BuildContext)> getRoutes(BuildContext context){
    Map<String,Widget Function(BuildContext)> router = {};
    for(var route in routes()){
      router[route[PATH]] = (context)=>route[VIEW];
    }
    return router;
  }
}