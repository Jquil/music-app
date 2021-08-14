import 'package:audioplayers/audioplayers.dart';
import 'package:demo/provider/PlayStateProvider.dart';
import 'package:demo/provider/SongProvider.dart';
import 'package:demo/utils/MyAudio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayRow extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]
      ),
      child: Row(
        children: [
          Image.network(context.watch<SongProvider>().song.albumpic,width: 50,height: 50,),
          Expanded(child:
          Container(
            margin: EdgeInsets.only(left:10),
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Text(context.watch<SongProvider>().song.name.length > 10 ? "${context.watch<SongProvider>().song.name.substring(0,10)}..." : context.watch<SongProvider>().song.name,style: TextStyle(fontSize: 14),maxLines: 1,overflow: TextOverflow.ellipsis),
                Text(context.watch<SongProvider>().song.artist.length > 10 ? " - ${context.watch<SongProvider>().song.artist.substring(0,10)}..." : " - ${context.watch<SongProvider>().song.artist}",style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)
              ],
            ),
          ),flex: 1,),

          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: (){
                  bool isPlaying = MyAudio.getState() == AudioPlayerState.PLAYING ? true : false;
                  MyAudio.setState(isPlaying ? AudioPlayerState.PAUSED : AudioPlayerState.PLAYING, context);
                },
                icon: context.watch<PlayStateProvider>().state == AudioPlayerState.PAUSED ? Icon(Icons.pause_circle_outline) : Icon(Icons.play_circle_outline))
            ),
        ],
      ),
    );
  }
}