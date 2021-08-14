import 'package:demo/api/Constant.dart';
import 'package:demo/db/MyDB.dart';
import 'package:demo/db/TBCollectListInfo.dart';
import 'package:demo/model/Song.dart';
import 'package:sqflite/sqflite.dart';

class TBCollectList{
  static final String TABLENAME          = "tb_collectlist_",
                      CM_ID              = "id",
                      CM_MUSICRID        = "musicrid",
                      CM_ARTIST          = "artist",
                      CM_ARTISTID        = "artistid",
                      CM_NAME            = "name",
                      CM_ALBUM           = "album",
                      CM_ALBUMPIC        = "albumpic",
                      CM_SONGTIMEMINUTES = "songTimeMinutes",
                      CM_HASMV           = "hasmv";

  static final ItemSize = 20;

  static void create(String name,int only,int key) async{
    await TBCollectListInfo.insert(name,only,key);
    MyDB.getDB()!.execute(CREATE(key));
  }


  static String CREATE(int key){
    return "create table ${TABLENAME}${key}("
        "${CM_ID} integer primary key autoincrement,"
        "${CM_MUSICRID} text,"
        "${CM_ARTIST} text,"
        "${CM_ARTISTID} integer,"
        "${CM_NAME} text,"
        "${CM_ALBUM} text,"
        "${CM_ALBUMPIC} text,"
        "${CM_SONGTIMEMINUTES} text,"
        "${CM_HASMV} integer"
        ")";
  }

  static Future<List<Song>> query(int key,int page) async{
    List<Map>? list = await MyDB.getDB()?.rawQuery("select * from ${TABLENAME}${key} order by ${CM_ID} desc limit ${Constant.ATTR_ITEM_SIZE} offset ${(page - 1) * Constant.ATTR_ITEM_SIZE}");
    return _toSongList(list!);
  }

  static Future<void> insert(int key,Song song,Function call) async{
    // 首先查询表中是否存在该歌曲，没有再添加
    List<Map>? query = await MyDB.getDB()?.rawQuery("select * from ${TABLENAME}${key} where ${CM_MUSICRID} = '${song.musicrid}'");
    if(query?.length != 0){
      call(1);
    }
    else{
      // insert
      MyDB.getDB()?.insert("${TABLENAME}${key}", song.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
      call(2);
    }
  }


  static List<Song> _toSongList(List<Map> data){
    return List.generate(data.length, (index) {
      return Song(
          data[index][CM_NAME],
          data[index][CM_ALBUM],
          data[index][CM_ALBUMPIC],
          data[index][CM_ARTIST],
          data[index][CM_ARTISTID],
          data[index][CM_HASMV],
          data[index][CM_MUSICRID],
          data[index][CM_SONGTIMEMINUTES]);
    });
  }
}