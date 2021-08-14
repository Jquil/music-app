import 'package:demo/api/Constant.dart';
import 'package:demo/http/MyDio.dart';
import 'package:demo/model/Artist.dart';
import 'package:demo/model/Bank.dart';
import 'package:demo/model/Song.dart';
import 'package:demo/model/Version.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class Service{

  final String CLASS = "Service";

  factory Service() => _instance;

  static final Service _instance = Service._internal();

  Service._internal(){
    // todo
  }

  // 获取榜单：只处理了“官方榜”
  Future<List<Bank>> getBankList() async{
    List<Bank> banks = [];
    try{
      Response res = await MyDio.dio.get(Constant.bankList);
      List list = json.decode(res.toString())['data'];

      for(var i = 0; i < list.length; i++){
        if(list[i]['name'] == "官方榜"){
          List l = list[i]['list'];
          banks = l.map((e) => Bank.fromJson((e as Map<String,dynamic>))).toList();
          break;
        }
      }
    }
    catch(e){
        print(e.toString());
    }
    return banks;
  }

  // 获取榜单音乐
  Future<List<Song>> getMusicByBank(int bankId,int page,int itemSize) async{
    List<Song> data = [];
    try{
      Response res = await MyDio.dio.get(Constant.getUrlOfMusicBank(bankId, page, itemSize));
      List list = json.decode(res.toString())['data']['musicList'];
      //log(list.toString());
      data = list.map((e) => Song.fromJson((e as Map<String, dynamic>))).toList();
    }
    catch(e){
      //print("${CLASS}："+e.toString());
    }
    return data;
  }

  // 获取歌曲播放地址
  Future<String> getRealMusicUrl(String musicrid) async{
    musicrid = musicrid.substring(6);
    String realURL = "";
    try{
      Response res = await MyDio.dio.get(Constant.getMusicUrl(musicrid));
      realURL = res.data.toString();
    }
    catch(e){

    }
    return realURL;
  }

  // 获取热门搜索
  Future<List> getHotSearch() async{
    MyDio.dio.options.headers['referer'] = MyDio.REFERER_ROOT;
    List data = [];
    try{
      Response res = await MyDio.dio.get(Constant.hotsearch);
      data = json.decode(res.toString())["data"];
    }
    catch(e){
      print(e.toString());
    }
    return data;
  }

  // 搜索
  Future<List<Song>> search(String key,int page,int size) async{
    MyDio.dio.options.headers['referer'] = MyDio.REFERER_SEARCH(Uri.encodeComponent(key));
    List<Song> data = [];

    try{
      Response res = await MyDio.dio.get(Constant.getSearchUrl(key, page, size));
      List list = json.decode(res.toString())['data']['list'];
      for(int i = 0; i < list.length; i++){
        data.add(Song.fromJson(list[i]));
      }
      //data = list.map((e) => Song.fromJson((e as Map<String, dynamic>))).toList();
    }
    catch(e){
      print(e.toString());
    }
    return data;
  }

  Future<Artist> artist(int id) async{
    Artist a = Artist("", 0, "", "", "", "", "", "", "");
    MyDio.dio.options.headers['referer'] = MyDio.REFERER_ROOT;
    try {
      Response res = await MyDio.dio.get(Constant.getArtistUrl(id));
      Map m = json.decode(res.toString())['data'];
      a = Artist.fromJson(m as Map<String,dynamic>);
    }
    catch(e){
      print("Service(artist):${e.toString()}");
    }
    return a;
  }


  Future<List<Song>> getArtistMusic(int id,int page) async{
    List<Song> data = [];
    try{
      MyDio.dio.options.headers['referer'] = MyDio.REFERER_ARTIST_SONG(id);
      Response res = await MyDio.dio.get(Constant.getArtistMusicUrl(id, page));
      List list = json.decode(res.toString())['data']['list'];
      for(int i = 0; i < list.length; i++){
        data.add(Song.fromJson(list[i]));
      }
    }
    catch(e){
      print("Service(getArtistMusic):${e.toString()}");
    }
    return data;
  }


  Future<Version> getNewestVersion() async{
    // https://jqwong.cn/api/music/version.html
    Version version = Version("", "", "", "", []);
    try{
      Response res = await MyDio.dio.get(Constant.version);
      Map map = json.decode(res.toString());
      version = Version(map['version'], map['title'], map['apk'], map['ipa'], map['content']);
    }
    catch(e){
      print("Service(getNewestVersion):${e.toString()}");
    }
    return version;
  }

  /*
    1. 设置Header涉及到中文需转码
    https://blog.csdn.net/Mr_Tony/article/details/112863187
  */
}