import 'package:audioplayers/audioplayers.dart';
import 'package:demo/api/Service.dart';
import 'package:demo/model/Song.dart';
import 'package:demo/provider/PlayStateProvider.dart';
import 'package:demo/provider/SongProvider.dart';
import 'package:demo/provider/SongQueueProvider.dart';
import 'package:demo/widget/CommonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAudio{

  // https://pub.flutter-io.cn/packages/audioplayers/changelog

  static final MyAudio instance = MyAudio._internal();

  factory MyAudio() => instance;

  static final AudioPlayer player = AudioPlayer();

  MyAudio._internal(){
    // todo
  }

  static play(BuildContext context,Song song) async{
    try{
      String url = await Service().getRealMusicUrl(song.musicrid);
      int res = await player.play(url);
      if(res == 1){
        context.read<SongProvider>().setSong(song);
      }
    }
    catch(e){
      print(e.toString());
    }
  }

  static AudioPlayerState getState(){
    return player.state;
  }

  static void setState(AudioPlayerState state,BuildContext context){
    if(context.read<SongQueueProvider>().list.length == 0){
      Scaffold.of(context).showSnackBar(CommonWidget().defaultSnackBar("播放列表中不存在歌曲~"));
      return;
    }
    context.read<PlayStateProvider>().setState(state);
    switch(state){
      case AudioPlayerState.PAUSED:
        player.pause();
        break;
      case AudioPlayerState.PLAYING:
        // 需二次处理
        player.resume();
        break;
      case AudioPlayerState.STOPPED:
        // TODO: Handle this case.
        break;
      case AudioPlayerState.COMPLETED:
        // TODO: Handle this case.
        break;
    }
  }


  /*
    1. 安装AudioPlayers遇到了很多错误，在不停地换版本试验，最终在18.1成功了
    2. 在项目build的时候出现：Execution failed for task ':audioplayers:compileDebugKotlin'.
      https://stackoverflow.com/questions/67832028/execution-failed-for-task-audioplayerscompiledebugkotlin
      ：android>build.gradle中修改kotlin版本
    3. 文档
    https://dengxiaolong.com/article/2019/07/how-to-play-audioplaxyers-in-flutter.html
  */
}