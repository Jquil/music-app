import 'package:demo/db/TBBank.dart';
import 'package:demo/db/TBCollectList.dart';
import 'package:demo/db/TBCollectListInfo.dart';
import 'package:demo/db/TBHotSearch.dart';
import 'package:demo/db/TBSinger.dart';
import 'package:demo/page/MinePage.dart';
import 'package:demo/utils/CommonUtil.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDB{

  static final MyDB _instance = MyDB._internal();

  static Database ?_db;

  factory MyDB(){
    return _instance;
  }

  MyDB._internal(){
    _init();
  }

  void _init() async{
    _db = await _open();
    MinePage.init();
  }

  Future<Database> _open() async{
    return openDatabase(
      join(await getDatabasesPath(),'music.db'),
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: 1
    );
  }



  void _onCreate(Database db,int version) async{
      var batch = db.batch();
      // 静态表
      batch.execute(TBBank.CREATE);
      batch.execute(TBHotSearch.CREATE);
      batch.execute(TBCollectListInfo.CREATE);

      var key = getUUid();
      batch.execute(TBCollectListInfo.insertSQL("我喜欢的音乐", 1, key));
      batch.execute(TBCollectList.CREATE(key));
      batch.execute(TBSinger.CREATE);
      batch.commit();
  }


  void _onUpgrade(Database db,int oldVersion,int newVersion) async{
    switch(oldVersion){

    }
  }


  static Database? getDB(){
    return _db;
  }


  /*
  数据库版本更新
  https://blog.csdn.net/heming9174/article/details/93195718
   */
}