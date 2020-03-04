import 'package:my_son_birthday/Entities/SonDetailsClass.dart';
import 'package:sqflite/sqflite.dart';

class SonDatabase {
  Database db;

  initDB() async {
    db = await openDatabase('my_son_birthday_DB.db', version: 1,
    onCreate: (Database data, int version){
      data.execute("CREATE TABLE sonDetailsDB (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "name TEXT, bornYear TEXT , "
          "currentAge TEXT, "
          "nextAge TEXT)");
    } );
    print("DB Inicializada");
  }

  insert(SonDetails sonDetails) async{
    db.insert('sonDetailsDB', sonDetails.toMap());
  }

  update(SonDetails sonDetails) async{
    db.update('sonDetailsDB',sonDetails.toMap(),where: "id=?",whereArgs: [sonDetails.id]);
  }
  
  delete(SonDetails sonDetails) async{
    db.delete('sonDetailsDB',where: "id=?",whereArgs: [sonDetails.id]);
  }
  
  Future<List<SonDetails>> getAll() async{
    List<Map<String,dynamic>> results = await db.query('sonDetailsDB');
    return results.map((map) => SonDetails.fromMap(map)).toList();
  }

}
