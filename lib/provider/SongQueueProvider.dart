import 'package:demo/model/Song.dart';
import 'package:demo/utils/MyAudio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SongQueueProvider with ChangeNotifier{
  List<Song> _list = [];

  List<Song> get list => _list;

  void setData(BuildContext context,List<Song> data){
    _push(data);
    _doTask(context);
    notifyListeners();
  }

  void next(BuildContext context){
    _pop();
    _doTask(context);
    notifyListeners();
  }

  void _push(List<Song> data){
    _popAll();
    _list.addAll(data);
  }

  void _pop(){
    if(_list.length == 0)
      return;
    _list.removeAt(0);
  }

  void _popAll(){
    _list.clear();
  }

  void _doTask(BuildContext context){
    if(_list.length == 0)
      return;
    MyAudio.play(context, _list[0]);
  }



}