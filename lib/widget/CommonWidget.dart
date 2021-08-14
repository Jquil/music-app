import 'package:demo/api/Constant.dart';
import 'package:demo/db/TBCollectList.dart';
import 'package:demo/db/TBCollectListInfo.dart';
import 'package:demo/db/TBSinger.dart';
import 'package:demo/model/Artist.dart';
import 'package:demo/model/Song.dart';
import 'package:demo/model/SongSheet.dart';
import 'package:demo/provider/SongQueueProvider.dart';
import 'package:demo/routers/MyRouter.dart';
import 'package:demo/utils/CommonUtil.dart';
import 'package:demo/utils/behavior/OverScrollBehavior.dart';
import 'package:demo/widget/ListTitleSong.dart';
import 'package:demo/widget/PlayingList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
class CommonWidget{

  static CommonWidget instance = CommonWidget._internal();

  factory CommonWidget() => instance;

  CommonWidget._internal(){
    // todo
  }

  Widget Title(String title){
    return Container(
      margin: EdgeInsets.all(10),
      child: Align(child: Text(title,style: TextStyle(fontSize: 18)),alignment: Alignment.centerLeft,),
    );
  }

  Widget ScrollView_Song(List<Song> data,String title,Image image,ScrollController sc,List<int> status,BuildContext scaffoldContext){
    return CustomScrollView(
      controller: sc,
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          title: Text(title,style: TextStyle(fontSize: 16)),
          expandedHeight: 230,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: image,
          ),
        ),
        SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                    (context, index){
                  if(index == data.length){
                    return CommonWidget().buildProgressIndicator(status);
                  }
                  else{
                    return ListTitleSong(index: index, song: data[index],scaffoldContext: scaffoldContext,
                        call: (song,index){
                          print(data.getRange(index, data.length-1));
                        }
                    );
                  }
                },
                childCount: data.length + 1),
            itemExtent: 60
        ),
      ],
    );
  }

  Widget ListView_Song(BuildContext scaffoldContext,List<Song> data,ScrollController sc,List<int> status,Function call){

    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: data.length + 1,
        itemBuilder: (BuildContext context, int index) {

          if(index == data.length){
            return buildProgressIndicator(status);
          }
          else{
            return ListTitleSong(index: index, song: data[index], scaffoldContext: scaffoldContext, call: call);
          }
        },

        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1.0, color: Colors.black12,indent: 5,endIndent: 5),
        controller: sc,
      ),
    );

  }

  Widget ListTitle_Song(Song song,int index,Function call){
    double left = (-16 + (((index+1).toString().length) * 5));
    return ListTile(
      leading: Text(" ${(index+1).toString()}",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
      title:
      Transform(
          transform: Matrix4.translationValues(left, 0.0, 0.0),
          child: Text(song.name,style: TextStyle(fontSize: 14),maxLines: 1,overflow: TextOverflow.ellipsis)),
      subtitle:
      Transform(
          transform: Matrix4.translationValues(left, 0.0, 0.0),
          child: Text("${song.artist} - ${song.album}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10))),
      dense: true,
      onTap: (){
        call(song,index);
      },
    );
  }

  Widget buildProgressIndicator(List<int> status) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: status[0] == Constant.STATUS_LOADEDALL ? Text("数据全部加载完成",style: TextStyle(fontSize: 12)) : CircularProgressIndicator()
      ),
    );
  }

  SnackBar defaultSnackBar(String content){
    return SnackBar(content: Text(content));
  }

  addSongSheetDialog(BuildContext context,TextEditingController tc,Function call) async{
    var alertDialogs = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("新建歌单"),
            content: TextField(
              controller: tc,
              decoration: InputDecoration(
                hintText: "请输入歌单名称",
                hintStyle: TextStyle(fontSize: 13), // 取消下边框
                contentPadding: EdgeInsets.all(0),
              )
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text("取消"),
                  onPressed: () => Navigator.pop(context, "cancel")),
              FlatButton(
                  child: Text("确定"),
                  onPressed: (){
                    Navigator.pop(context, "yes");
                    call();
                  }),
            ],
          );
        });
    return alertDialogs;
  }

  showSongSheetDialog(BuildContext context1,BuildContext context2,Song song) async{
    List<SongSheet> data = await TBCollectListInfo.getAll();
    showModalBottomSheet(
        context: context1,
        builder: (context) {
          return Container(
            width: double.infinity,
            height: 200,
            margin: EdgeInsets.all(10),
            child: songSheetView(data,(SongSheet sheet){
                // 收藏
              String content = "";
              TBCollectList.insert(sheet.key, song, (int code){
                switch(code){
                  case 1:
                    content = "歌曲已存在";
                    break;
                  case 2:
                    content = "收藏成功";
                    break;
                }
                Navigator.pop(context);
                Scaffold.of(context2).showSnackBar(defaultSnackBar(content));
              });
            })
          );
        });
  }

  showCollectSinger(BuildContext context) async{
    List<Artist> data = await TBSinger.getAll();
    //print(data[0].);
    showModalBottomSheet(
        context: context,
        builder: (context){
          return data.length > 0 ?
           ListView.separated(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.network(data[index].pic,height: 50,width: 50,fit: BoxFit.cover,),
                      ),
                      Text("  ${data[index].name.length > 15 ? data[index].name.substring(0,15) : data[index].name }")
                    ],
                  ),

                ),
                onTap: (){
                  Navigator.of(context).pushNamed(MyRouter.PAGE_SINGER,arguments: int.parse(data[index].info));
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 1.0, color: Colors.black12,indent: 5,endIndent: 5),
          )
          :  Container(
            margin: EdgeInsets.all(10),
            child: Text("暂无不存在收藏的歌手~"),
          );
        }
    );
  }

  showPlayingList(BuildContext context,BuildContext scaffoldContext) async{
    // context.watch<SongProvider>().song.name
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PlayingList();
        });
  }

  ListView songSheetView(List<SongSheet> data,Function call){
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) =>
            ListTile(
              title: Text(data[index].name,style: TextStyle(fontSize: 14)),
              onTap: ()=>{
                call(data[index])
              },
            ),
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1.0, color: Colors.black12,indent: 10,endIndent: 10),
        itemCount: data.length);
  }

  /*
    1. Flutter 回调函数
    https://blog.csdn.net/Mr_Tony/article/details/111832368

    2. 去除ListView滑动波纹
    https://www.jianshu.com/p/78ec33645e36

    3. 圆角图片
    https://blog.csdn.net/jking54/article/details/97822285

    4. Flutter 阴影框效果
    https://blog.csdn.net/Ani/article/details/106383623
  * */
}
