import 'package:demo/api/Constant.dart';
import 'package:demo/api/Service.dart';
import 'package:demo/model/Song.dart';
import 'package:demo/utils/CommonUtil.dart';
import 'package:demo/utils/MyAudio.dart';
import 'package:demo/widget/PlayRow.dart';
import 'package:demo/widget/ScrollViewSong.dart';
import 'package:flutter/material.dart';

class SearchListPage extends StatefulWidget{

  @override
  State createState() {
    return _SearchListState();
  }
}

class _SearchListState extends State<SearchListPage>{

  String searchKey = "";
  bool isFirstLoaded = false;
  List<int >status = [Constant.STATUS_DEFAULT];
  Song ? nSong;

  final pageItemSize = 20,maxSize = 100;
  int page = 0;

  List<Song> data = [];
  ScrollController _sc = ScrollController();
  int lastTime = 0,dis = 1000000;

  @override
  void initState() {
    super.initState();
    _sc.addListener(() {
      if(_sc.position.pixels == _sc.position.maxScrollExtent){
        getSearchData();
      }
    });
  }


  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    searchKey = ModalRoute.of(context)?.settings.arguments as String;
    if(!isFirstLoaded){
      getSearchData();
      isFirstLoaded = true;
    }
    return Scaffold(
        body: Builder(builder: (BuildContext context){
          return Flex(
            direction: Axis.vertical,
            children: [
              Expanded(child: ScrollViewSong(data:data, title:searchKey, image:getAssetImage(), sc:_sc, status: status, scaffoldContext: context, call:(){
              }),flex: 1,),
              PlayRow()
            ],
          );
        })
    );
  }


  void getSearchData() async{
    if(status[0] == Constant.STATUS_LOADEDALL)
      return;

    if(searchKey == "")
      return;

    var now = DateTime.now().microsecondsSinceEpoch;
    if(now - lastTime < dis){
      return;
    }
    lastTime = now;

    setState(() {
      status[0] = Constant.STATUS_LOADING;
    });
    page++;
    List<Song> list = await Service().search(searchKey, page, pageItemSize);

    setState(() {
      data.addAll(list);
      if(list.length < Constant.ATTR_ITEM_SIZE || data.length == Constant.ATTR_MAX_SIZE){
        status[0] = Constant.STATUS_LOADEDALL;
      }
      else{
        status[0] = Constant.STATUS_LOADING;
      }
    });
  }

  void play(BuildContext context,Song song,int index) async{
    nSong = song;
    MyAudio.play(context,song);
  }

  /*
    1. Flutter时间戳是13位，所以1秒 = 1000000
    2. 配置静态图片
      https://www.freesion.com/article/6838947249/
    3. Flutter SliverAppBar全解析，你要的效果都在这了！
      https://blog.csdn.net/yechaoa/article/details/90701321
      https://www.codercto.com/a/34161.html
  * */
}