import 'package:demo/model/Song.dart';
import 'package:demo/provider/SongQueueProvider.dart';
import 'package:demo/widget/CommonWidget.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'ListTitleSong.dart';

// ignore: must_be_immutable
class ScrollViewSong extends StatefulWidget {
  List<Song> data;
  String title;
  Image image;
  ScrollController sc;
  List<int> status;
  Function call;
  BuildContext scaffoldContext;

  ScrollViewSong({required this.data,required this.title,required this.image,required this.sc,required this.status,required this.scaffoldContext,required this.call});

  @override
  State createState() {
    return _StateScrollViewSong(data: data,title: title,image: image,sc: sc,status: status,scaffoldContext:scaffoldContext,call: call);
  }
}

class _StateScrollViewSong extends State<ScrollViewSong>{

  List<int> status;
  List<Song> data;
  String title;
  Image image;
  ScrollController sc;
  BuildContext scaffoldContext;
  Function call;

  _StateScrollViewSong({required this.data,required this.title,required this.image,required this.sc,required this.status,required this.scaffoldContext,required this.call});


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          play(context,data.getRange(index, data.length).toList(), song, index);
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


  void play(BuildContext context,List<Song> data,Song song,int index){
    context.read<SongQueueProvider>().setData(context,data);
  }
}