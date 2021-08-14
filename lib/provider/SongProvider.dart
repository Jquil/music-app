import 'package:demo/model/Song.dart';
import 'package:flutter/foundation.dart';

class SongProvider with ChangeNotifier{

  Song _song = Song("平凡之路", "猎户星座", "https://img4.kuwo.cn/star/albumcover/500/75/9/3640622973.jpg", "朴树", 1504, 1, "MUSIC_5960811", "05:01");

  Song get song => _song;

  void setSong(Song song){
    _song = song;
    notifyListeners();
  }
}