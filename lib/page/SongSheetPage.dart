import 'package:demo/api/Constant.dart';
import 'package:demo/db/TBCollectList.dart';
import 'package:demo/model/Song.dart';
import 'package:demo/utils/CommonUtil.dart';
import 'package:demo/widget/PlayRow.dart';
import 'package:demo/widget/ScrollViewSong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SongSheetPage extends StatefulWidget{

  SongSheetPage();

  @override
  State createState() {
    return _StateSongSheetPage();
  }
}

class _StateSongSheetPage extends State<SongSheetPage>{
  int mkey = 0;
  int page = 0;
  List<int >status = [Constant.STATUS_DEFAULT];
  bool isFistLoaded = false;
  List<Song> data = [];
  ScrollController _sc = ScrollController();
  Map ?map;
  _StateSongSheetPage();


  @override
  void initState() {
    super.initState();
    _sc.addListener(() {
      if(_sc.position.pixels == _sc.position.maxScrollExtent){
        getSheetData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!isFistLoaded){
      map = ModalRoute.of(context)?.settings.arguments as Map;
      mkey = map?[Constant.ATTR_KEY];
      isFistLoaded = true;
      getSheetData();
    }
    return Scaffold(
      body: Builder(builder: (BuildContext context){
        return Flex(
          direction: Axis.vertical,
          children: [
            Expanded(child: ScrollViewSong(data:data, title:"${map?[Constant.ATTR_TITLE]}", image:getAssetImage(), sc:_sc, status: status, scaffoldContext: context, call: (){

            }),flex: 1,),
            PlayRow()
          ],
        );
      }),
    );
  }

  void getSheetData() async{
    if(status[0] == Constant.STATUS_LOADEDALL)
      return;
    setState(() {
      status[0] = Constant.STATUS_LOADING;
    });
    page++;
    List<Song> temp = await TBCollectList.query(mkey, page);

    setState(() {
      data.addAll(temp);
      status[0] = temp.length < Constant.ATTR_ITEM_SIZE ? Constant.STATUS_LOADEDALL : Constant.STATUS_LOADING;
    });

  }
}


  /*
    21/07/31
      下午遇到一个问题：在Page引入了外部的StatefulWidget，我在Page中setState进行更新状态，对于Widget中的数据列表有更新到
    但是对于bool,int类型数据没有更新
    ......
    ......
      弄到了晚上，突然想到：在C语言中，方法传递数组时是以地址传递，而int，String..是以单向值传递的
    后面我将int数据放在数组中，然后更新，结果就OK了
      因为一开始我是认为Widget是装载到Page中的，因此我在Page中通过setState也是会更新Widget中的State
  */