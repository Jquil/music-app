import 'dart:math';

import 'package:demo/api/Constant.dart';
import 'package:demo/model/Song.dart';
import 'package:demo/provider/SongQueueProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';

double getShowViewHeight(BuildContext context){
  return MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top - 70;
}


BuildContext getContext(){
  return navigatorKey.currentState!.overlay!.context;
}


int getUUid() {
  // https://zhuanlan.zhihu.com/p/359330989
  String randomstr = Random().nextInt(10).toString();
  for (var i = 0; i < 3; i++) {
    var str = Random().nextInt(10);
    randomstr = "$randomstr" + "$str";
  }
  var timenumber = DateTime.now().millisecondsSinceEpoch;//时间
  var uuid = "$randomstr" + "$timenumber";
  return int.parse(uuid);
}

Image getAssetImage(){
  return Image.asset(Constant.assetImageList[Random().nextInt(Constant.assetImageList.length)],fit: BoxFit.cover);
}


play(BuildContext context,List<Song> data,Song song,int index){
  context.read<SongQueueProvider>().setData(context,data);
}