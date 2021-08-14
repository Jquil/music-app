import 'package:demo/model/Artist.dart';
import 'package:sqflite/sqflite.dart';

import 'MyDB.dart';

class TBSinger{
  static final String TABLENAME  = "tbsinger",
      CM_ID        = "id",
      CM_ARTIST_ID = "artistid",
      CM_ARTIST    = "artist",
      CM_PIC       = "pic",
      CREATE       = 'create table $TABLENAME($CM_ID integer primary key autoincrement, $CM_ARTIST_ID integer, $CM_ARTIST text,$CM_PIC text)';

  static void insert(Map<String,dynamic> map,Function call) async{
    List<Map>? query = await MyDB.getDB()?.rawQuery("select * from ${TABLENAME} where ${CM_ARTIST_ID} = ${map[CM_ARTIST_ID]}");
    if(query?.length != 0){
      call(1);
    }
    else{
      // insert
      MyDB.getDB()?.insert("${TABLENAME}", map,conflictAlgorithm: ConflictAlgorithm.replace);
      call(2);
    }
  }

  static Future<List<Artist>> getAll() async{
    List<Map>? list = await MyDB.getDB()?.rawQuery("select * from ${TABLENAME}");
    return _toArtistList(list!);
  }

  static List<Artist> _toArtistList(List<Map> data){
    return List.generate(data.length, (index) {
      return Artist("", 0, "", data[index][CM_PIC], "", "", "", data[index][CM_ARTIST], data[index][CM_ARTIST_ID].toString());
    });
  }
}