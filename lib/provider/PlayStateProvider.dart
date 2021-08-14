import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class PlayStateProvider with ChangeNotifier{

  AudioPlayerState _state = AudioPlayerState.PAUSED;

  AudioPlayerState get state => _state;

  void setState(AudioPlayerState state){
      _state = state;
      notifyListeners();
  }

  AudioPlayerState getState(){
    return _state;
  }
}