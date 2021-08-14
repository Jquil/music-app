class TBLike{

  factory TBLike() => _instance;

  static TBLike _instance = TBLike._internal();

  static final String TABLENAME  = "tblike",
                       CM_ID     = "id",
                       CM_SINGER = "singer",
                       CM_SONG   = "song",
                       CREATE    = 'create table $TABLENAME($CM_ID integer primary key autoincrement, $CM_SINGER text, $CM_SONG text)';

  var db;

  TBLike._internal(){

  }


  /*
  void insert(Like like) async{
    handle((db) {
      db.insert(TABLENAME, like.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  void queryBySinger(String singer,QueryCall queryCall) async{
    await handle((db) {
      Future<List<Map>> list = db.rawQuery('select * from $TABLENAME where $CM_SINGER like \'%$singer%\'');
      list.then((value) =>
          queryCall.call(value)
      );
    });
  }
  
  void deleteById(int id) async{
    await handle((db) { 
      db.delete(
          TABLENAME,
          where: '$CM_ID = ?',
          whereArgs: [id]
      );
    });
  }

  void updateById(Like like) async{
    await handle((db) {
      db.update(TABLENAME, like.toMap(),where: '$CM_ID = ?',whereArgs: [like.id]);
    });
  }

  Future<void> handle (DBCall dbCall) async{
    await MyDB().getInstance().then((db) =>
        dbCall.call(db)
    );
  }

  Future<void> initDB() async{
    if(db == null){
      db = await MyDB().getInstance();
    }
  }

  List<Like> toLike(List<Map> maps){
    return List.generate(maps.length, (index){
      return Like(id: maps[index]['id'], singer: maps[index]['singer'], song: maps[index]['song']);
    });
  }
  */


}