import 'MyDB.dart';

class TBHotSearch{
  static final String TABLENAME  = "tbhotsearch",
      CM_ID      = "id",
      CM_NAME    = "name",
      CREATE     = 'create table $TABLENAME($CM_ID integer primary key autoincrement, $CM_NAME text)';


  static void update(List data) async{
    // 删除原有Bank
    // 添加现有Bank
    await delete();
    await insert(data);
  }

  static Future<void> delete() async{
    String sql = "delete from ${TABLENAME}";
    MyDB.getDB()?.execute(sql);
  }


  static Future<void> insert(List data) async{
    data.forEach((el) {
      MyDB.getDB()?.rawInsert("insert into ${TABLENAME}(${CM_NAME}) values('${el}')");
    });
  }

  static Future<List<String>> getAll() async{
    String sql = "select * from ${TABLENAME}";
    List<Map> ?list = await MyDB.getDB()?.rawQuery(sql);
    return toList(list!);
  }

  static List<String> toList(List<Map> maps){
    return List.generate(maps.length, (index){
      return maps[index][CM_NAME].toString();
    });
  }
}