import 'package:demo/db/MyDB.dart';
import 'package:demo/model/Bank.dart';
import 'package:sqflite/sqflite.dart';

class TBBank{
  factory TBBank() => instance;

  static TBBank instance = TBBank._internal();

  TBBank._internal(){
    // todo
  }

  static final String TABLENAME  = "tbbank",
      CM_ID      = "id",
      CM_NAME    = "name",
      CM_SOUCEID = "sourceid",
      CM_IMG     = "pic",
      CREATE     = 'create table $TABLENAME($CM_ID integer primary key autoincrement, $CM_NAME text, $CM_SOUCEID int,$CM_IMG text)';


  void updateBank(List<Bank> data) async{
    // 删除原有Bank
    // 添加现有Bank
    await delete();
    await insert(data);
  }

  Future<void> delete() async{
    String sql = "delete from ${TABLENAME}";
    MyDB.getDB()?.execute(sql);
  }


  Future<void> insert(List<Bank> data) async{
    data.forEach((el) {
      MyDB.getDB()?.insert(TABLENAME, el.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<List<Bank>> getAll() async{
    String sql = "select * from ${TABLENAME}";
    List<Map> ?list = await MyDB.getDB()?.rawQuery(sql);
    return toBankList(list!);
  }

  List<Bank> toBankList(List<Map> maps){
    return List.generate(maps.length, (index){
      return Bank(maps[index]['${CM_SOUCEID}'].toString(), maps[index]['${CM_IMG}'], maps[index]['${CM_NAME}']);
    });
  }
}