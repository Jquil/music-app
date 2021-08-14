import 'package:demo/api/Constant.dart';
import 'package:demo/api/Service.dart';
import 'package:demo/db/TBSinger.dart';
import 'package:demo/model/Artist.dart';
import 'package:demo/model/Song.dart';
import 'package:demo/utils/CommonUtil.dart';
import 'package:demo/widget/CommonWidget.dart';
import 'package:demo/widget/ListTitleSong.dart';
import 'package:demo/widget/PlayRow.dart';
import 'package:demo/widget/ScrollViewSong.dart';
import 'package:flutter/material.dart';

class SingerPage extends StatefulWidget{

  @override
  State createState() {
    return _StateSingerPage();
  }
}

class _StateSingerPage extends State<SingerPage>{

  int id = 0;
  Artist ?artist;
  String title = "";
  List<Song> data = [];
  ScrollController _sc = ScrollController();
  bool isLoadArtist = false;
  List<int> status = [Constant.STATUS_LOADING];
  int page = 0;

  @override
  void initState() {
    super.initState();
    _sc.addListener(() {
      if(_sc.position.pixels == _sc.position.maxScrollExtent){
        _loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(id == 0){
      id = ModalRoute.of(context)?.settings.arguments as int;
      _loadData();
    }
    return Scaffold(
      body: Builder(builder: (BuildContext context){
        return Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                  flex: 1,
                  child: CustomScrollView(
                    controller: _sc,
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        title: Text(title,style: TextStyle(fontSize: 16)),
                        expandedHeight: 230,
                        pinned: true,
                        actions: [
                          PopupMenuButton(itemBuilder: (context) => <PopupMenuEntry<String>>[
                            PopupMenuItem(
                              child: Text('收藏歌手'),
                              value: "1",
                            ),
                          ],
                            onSelected: (v){
                              switch(int.parse(v.toString())){
                                case 1:
                                  collectSinger(context);
                                  break;
                              }
                            },
                          )
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          background:
                          FutureBuilder(
                              future: _loadArtist(id),
                              builder: (BuildContext context, AsyncSnapshot<Artist?> snapshot){
                                if(snapshot.connectionState == ConnectionState.done){
                                  //print("Header:${snapshot.data}");
                                  String url = "";
                                  url = snapshot.data!.pic.replaceAll("/120/", "/300/");
                                  print(url.replaceAll("/120/", "/300/"));
                                  return Image.network(url,fit: BoxFit.cover,);
                                }
                                return Text("");
                              }
                          ),
                        ),
                      ),
                      SliverFixedExtentList(
                          delegate: SliverChildBuilderDelegate(
                                  (context, index){
                                if(index == data.length){
                                  return CommonWidget().buildProgressIndicator(status);
                                }
                                else{
                                  return ListTitleSong(index: index, song: data[index],scaffoldContext: context,
                                      call: (song,index){
                                        play(context,data.getRange(index, data.length).toList(), song, index);
                                      }
                                  );
                                }
                              },
                              childCount: data.length + 1),
                          itemExtent: 60
                      ),
                    ],
                  )
              ),
              PlayRow()
            ]
        );
      })
    );
  }

  Future<Artist?> _loadArtist(int id) async{
    if(isLoadArtist)
      return artist;
    artist = await Service().artist(id);
    isLoadArtist = true;
    title = artist!.name;
    return artist;
  }

  void _loadData() async{

    if(status[0] == Constant.STATUS_LOADEDALL)
      return;


    setState(() {
      status[0] = Constant.STATUS_LOADING;
    });
    page++;
    List<Song> list = await Service().getArtistMusic(id,page);

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

  void collectSinger(BuildContext context){
    Map<String,dynamic> map = Map();
    map[TBSinger.CM_ARTIST_ID] = id;
    map[TBSinger.CM_ARTIST] = artist?.name;
    map[TBSinger.CM_PIC] = artist?.pic;
    TBSinger.insert(map,(int status){
      String content = "";
      switch(status){
        case 1:
          content = "该歌手已收藏~";
          break;
        case 2:
          content = "收藏成功~";
          break;
      }
      print(content);
      Scaffold.of(context).showSnackBar(CommonWidget().defaultSnackBar(content));

    });
  }
}