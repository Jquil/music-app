import 'package:demo/model/Song.dart';
import 'package:demo/routers/MyRouter.dart';
import 'package:demo/widget/CommonWidget.dart';
import 'package:flutter/material.dart';

class ListTitleSong extends StatefulWidget{

  final Song song;
  final int index;
  final Function call;
  final BuildContext scaffoldContext;

  ListTitleSong({required this.index,required this.song,required this.scaffoldContext,required this.call});

  @override
  State createState() {
    return _StateListTitle_Song(index: index,song: song,scaffoldContext:scaffoldContext,call: call);
  }
}


class _StateListTitle_Song extends State<ListTitleSong>{

  final Song song;
  final int index;
  final BuildContext scaffoldContext;
  final Function call;

  _StateListTitle_Song({required this.index,required this.song,required this.scaffoldContext,required this.call});

  @override
  Widget build(BuildContext context) {
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
      trailing:
      PopupMenuButton(
        itemBuilder: (context) => <PopupMenuEntry<String>>[
          PopupMenuItem(
            child: Text('添加到歌单'),
            value: "1",
          ),
          PopupMenuItem(
            child: Text('查看歌手'),
            value: "2",
          ),
        ],
        onSelected: (v){
          switch(int.parse(v.toString())){
            case 1:
              collectToLike(context,scaffoldContext,song);
              break;
            case 2:
              Navigator.of(context).pushNamed(MyRouter.PAGE_SINGER,arguments: song.artistid);
              break;
          }
        },),
      dense: true,
      onTap: (){
        call(song,index);
      },
    );
  }

  void collectToLike(BuildContext context,BuildContext scaffoldContext,Song song) async{
    CommonWidget.instance.showSongSheetDialog(context,scaffoldContext,song);
    //Scaffold.of(context).showSnackBar(CommonWidget().defaultSnackBar("添加成功"));
  }
}