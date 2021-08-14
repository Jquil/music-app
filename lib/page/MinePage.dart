import 'package:demo/api/Constant.dart';
import 'package:demo/db/TBCollectList.dart';
import 'package:demo/db/TBCollectListInfo.dart';
import 'package:demo/model/SongSheet.dart';
import 'package:demo/routers/MyRouter.dart';
import 'package:demo/utils/CommonUtil.dart';
import 'package:demo/utils/Icons.dart';
import 'package:demo/widget/CommonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;


class MinePage extends StatefulWidget{

  static MinePage _instance = MinePage._internal();

  factory MinePage() => _instance;

  MinePage._internal(){
    // todo
  }

  _MinePageState state = _MinePageState();

  @override
  _MinePageState createState(){
    return state;
  }

  static void init(){
    if(_instance == null)
      return;
    _instance.state.initSongSheet();
  }
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin<MinePage>,TickerProviderStateMixin{
  static final String ICO = "ico",TITLE = "title";
  List<SongSheet> mSongSheet = [];
  TextEditingController _tc = TextEditingController();
  double to = 0;
  bool hidden = true;
  final List _data = [
    {
      TITLE:"本地音乐",
      ICO: iconLocation()
    },
    {
      TITLE:"播放列表",
      ICO:iconPlay()
    },
    {
      TITLE:"收藏的歌手",
      ICO:Icon(Icons.people,size: 30,)
    },
    {
      TITLE:"我的喜欢",
      ICO:iconFavorite()
    }
  ];


  @override
  void initState() {
    super.initState();
    //print(getContext().watch<SongProvider>().song.name);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Builder(builder: (BuildContext scaffoldContext){
          return Container(
            width: double.infinity,
            child: Column(
              children: [
                _commonView(scaffoldContext),
                Container(
                    constraints: BoxConstraints.expand(
                      width: double.infinity,
                      height: 10,
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(5, 0, 0, 0)
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Expanded(child: child),
                      Transform.rotate(
                          angle: to,
                          alignment: Alignment.center,
                          child: Icon(Icons.keyboard_arrow_up)),
                      Expanded(
                          child:
                          GestureDetector(
                            child:Text("  创建的歌单(${mSongSheet.length})"),
                            onTap: () => {
                              showSongSheet()
                            },
                          )
                      ),
                      GestureDetector(
                        child: Container(
                          child: Icon(Icons.add),
                          margin: EdgeInsetsDirectional.only(end: 20),
                        ),
                        onTap: ()=>{
                          addSongSheet()
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Offstage(
                      offstage: hidden, // true:不可见 false:可见
                      child: CommonWidget.instance.songSheetView(mSongSheet,(SongSheet sheet){
                        _toSongSheetPage(sheet);
                      }),
                    ))
              ],
            ),
          );
        }
    ));
  }

  @override
  bool get wantKeepAlive {
    return true;
  }


  ListView _commonView(BuildContext scaffoldContext){
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) =>
            ListTile(
              leading: _data[index][ICO],
              title: Text(_data[index][TITLE],style: TextStyle(fontSize: 14)),
              onTap: ()=>{
                handleCommonViewClick(scaffoldContext,index)
              },
            ),
        separatorBuilder: (BuildContext context, int index) =>
        Divider(height: 1.0, color: Colors.black12,indent: 70,endIndent: 30),
        itemCount: _data.length);
  }


  void handleCommonViewClick(BuildContext scaffoldContext,int index){
    switch(index){
      case 0:
        // 本地音乐
        Scaffold.of(context).showSnackBar(CommonWidget.instance.defaultSnackBar("该版本暂未开放该功能~"));
        break;
      case 1:
        // 播放列表
        CommonWidget.instance.showPlayingList(context,scaffoldContext);
        break;
      case 2:
        // 收藏的歌手
        //Scaffold.of(context).showSnackBar(CommonWidget.instance.defaultSnackBar("该版本暂未开放该功能~"));
        CommonWidget.instance.showCollectSinger(scaffoldContext);
        break;
      case 3:
        // 我的喜欢
        if(mSongSheet.length == 0)
          return;
        for(int i = 0; i < mSongSheet.length; i++){
          if(mSongSheet[i].only == 1){
            _toSongSheetPage(mSongSheet[i]);
            break;
          }
        }
        break;
    }
  }

  void addSongSheet(){
    _tc.text = "";
    CommonWidget.instance.addSongSheetDialog(context,_tc,(){
      if(_tc.text == "")
        return;
      var uuid = getUUid();
      TBCollectList.create(_tc.text, 0, uuid);
      SongSheet sheet = SongSheet(mSongSheet[mSongSheet.length-1].id + 1, _tc.text, 0, uuid);
      mSongSheet.add(sheet);
      Scaffold.of(context).showSnackBar(CommonWidget.instance.defaultSnackBar("“${_tc.text}”歌单创建成功"));
      setState(() {});
    });
  }

  void showSongSheet(){
    setState(() {
      hidden = !hidden;
      to = hidden ? 0 : math.pi;
    });
  }

   void initSongSheet() async{
    mSongSheet = await TBCollectListInfo.getAll();
    setState(() {

    });
  }


  void _toSongSheetPage(SongSheet sheet){
    Map map = Map();
    map[Constant.ATTR_KEY]   = sheet.key;
    map[Constant.ATTR_TITLE] = sheet.name;
    Navigator.pushNamed(context, MyRouter.PAGE_SONGSHEET,arguments: map);
  }

}


/*
  1. 使用ListView出现：Vertical viewport was given unbounded height
  https://blog.csdn.net/xudailong_blog/article/details/95620600

  2. Flutter(五) ListView组件的使用
  https://www.jianshu.com/p/b8e1c2020bda

  3. flutter listview 设置分割线
  https://www.jianshu.com/p/26077de545d8

  4. Flutter中使用 iconfont 图标
  https://www.jianshu.com/p/cc1331443c3a
  https://www.cnblogs.com/yiweiyihang/p/11536024.html

  5. 设置Container背景色
  https://blog.csdn.net/u013425527/article/details/98216206

  6. 与屏同宽
  https://blog.csdn.net/weixin_44241694/article/details/106499609

  7. Container外边距
  https://blog.csdn.net/yyxgs/article/details/116561809
 */