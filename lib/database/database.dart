

// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DBProvider {
//   DBProvider();
//   static  DBProvider db = DBProvider();
//   static Database _database;

//   Future<Database> get database async {
//     if (_database != null)
//     return _database;

//     // if _database is null we instantiate it
//     _database = await initDB();
//         return _database;
//       }
    
//     initDB()  async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path=documentsDirectory.path+"/TestDB.db";
//     return await openDatabase(path, version: 1, onOpen: (db) {
//     }, onCreate: (Database db, int version) async {
//       await db.execute("CREATE TABLE Student ("
//           "id INTEGER PRIMARY KEY,"
//           "nom TEXT,"
//           "prenom TEXT,"
//           "className TEXT,"
//           "),"
//           "CREATE TABLE Presence ("
//           "id INTEGER PRIMARY KEY,"
//           "date TEXT,"
//           "isPresent INTEGER,"
//           "),"
//           );
//     });
//   }
// }

import 'package:EnsaAbs/model/classroom.dart';
import 'package:EnsaAbs/model/student.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class ORM {
     ORM();
   static  ORM db = ORM();
   static SqfliteAdapter _adapter;

  Future<SqfliteAdapter> get adapter async {
    if (_adapter != null)
       return _adapter;
   
      _adapter = await initORM();
        return _adapter;
   }


   initORM() async{
  await Sqflite.devSetDebugModeOn(true);
  var sb = StringBuffer();
  sb.writeln("Jaguar ORM showcase:");

  sb.writeln('--------------');
  sb.write('Connecting ...');
  var dbPath = await getDatabasesPath();
  return SqfliteAdapter(path.join(dbPath, "test.db"));

   }
   getCrBean() async {
        final adapter =await this.adapter;
       return ClassroomBean(adapter);
   }
   getStdBean() async {
       final adapter =await this.adapter;
       return StudentBean(adapter);
   }
}

//   Future<Database> get database async {
//     if (_database != null)
//     return _database;

//     // if _database is null we instantiate it
//     _database = await initDB();
//         return _database;
//       }