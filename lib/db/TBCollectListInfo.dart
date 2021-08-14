import 'package:demo/db/MyDB.dart';
import 'package:demo/model/SongSheet.dart';

class TBCollectListInfo{
  static final String TABLENAME  = "tb_collectlist_info",
      CM_ID      = "id",
      CM_NAME    = "name",
      CM_ONLY    = "only",
      CM_KEY     = "key",
      CREATE     = "create table ${TABLENAME}(${CM_ID} integer primary key autoincrement,${CM_NAME} text,$CM_ONLY integer,${CM_KEY} integer)";

  static Future<int> insert(String name,int only,int key) async{
    int id = await MyDB.getDB()!.rawInsert(insertSQL(name, only, key));
    return id;
  }

  static Future<List<SongSheet>> getAll() async{
    if(MyDB.getDB() == null)
      return [];
    List<Map>? list = await MyDB.getDB()?.rawQuery("select * from ${TABLENAME}");
    return toSongSheet(list!);
  }

  static String insertSQL(String name,int only,int key){
    return "insert into ${TABLENAME}(${CM_NAME},${CM_ONLY},${CM_KEY}) values('${name}',${only},${key})";
  }

  static List<SongSheet> toSongSheet(List<Map> maps){
    return List.generate(maps.length, (index){
      return SongSheet(maps[index]['${CM_ID}'], maps[index]['${CM_NAME}'], maps[index]['${CM_ONLY}'], maps[index]['${CM_KEY}']);
    });
  }
}