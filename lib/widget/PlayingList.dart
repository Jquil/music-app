import 'package:demo/api/Constant.dart';
import 'package:demo/model/Song.dart';
import 'package:demo/provider/SongQueueProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'CommonWidget.dart';

class PlayingList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return CommonWidget.instance.ListView_Song(context,context.watch<SongQueueProvider>().list,ScrollController(),[Constant.STATUS_LOADEDALL],(Song song,int index){
      List<Song> data = context.read<SongQueueProvider>().list.toList();
      context.read<SongQueueProvider>().setData(context,data.getRange(index, data.length).toList());
    });
  }
}