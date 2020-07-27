import 'dart:convert';
import 'dart:io';

import 'package:EnsaAbs/model/classroom.dart';
import 'package:EnsaAbs/model/presence.dart';
import 'package:EnsaAbs/model/student.dart';
import 'package:csv/csv.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

SqfliteAdapter _adapter;
var sb = StringBuffer();
ClassroomBean cBean;
StudentBean sBean;
PresenceBean pBean;

connect() async {
  if (_adapter == null) {
    await Sqflite.devSetDebugModeOn(true);
    sb.writeln("Jaguar ORM showcase:");

    sb.writeln('--------------');
    sb.write('Connecting ...');
    var dbPath = await getDatabasesPath();
    _adapter = SqfliteAdapter(path.join(dbPath, "test.db"));
  }
  await _adapter.connect();
  sb.writeln(' successful!');
  sb.writeln('--------------');
  cBean = ClassroomBean(_adapter);
  sBean = StudentBean(_adapter);
  pBean = PresenceBean(_adapter);
}

initdb() async {
  await cBean.drop();
  await sBean.drop();
  await pBean.drop();

  sb.writeln('Creating table ...');
  await cBean.createTable();
  await sBean.createTable();
  await pBean.createTable();
  sb.writeln('Removing old rows (if any) ...');
  await cBean.removeAll();
  await sBean.removeAll();
  await pBean.removeAll();
  sb.writeln(' successful!');
  sb.writeln('--------------');
}

insertNewFile(File file) async {
  final input = file.openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(new CsvToListConverter())
      .toList();
  print(fields.length);
  String str = file.path.split('/').last;
  String basename = str.substring(0, str.indexOf("."));
  print("this is  base: " + basename);
  print('Inserting $basename .....');
  List clarifyfield = [];
  List<Student> students = [];
  fields.forEach((element) {
    if (element.length != 1) clarifyfield.add(element);
  });

//test
  try {
    print("we R in try**************************************************");
    await connect();

    for (var i = 1; i < clarifyfield.length; i++) {
      students.add(new Student.make(
          null, clarifyfield[i][3], clarifyfield[i][2], 0, false, null));
    }
    students.forEach((value) {
      print("prenom: " + value.firstName);
    });
    Classroom c1 =
        new Classroom.make(null, basename, clarifyfield.length - 1, students);

    // // Insert some posts
    print('Inserting sample rows ...');
    int id1 = await cBean.insert(c1, cascade: true);
    print('Inserted successfully row with id: $id1 and one to many relation!');

  } catch (e) {
    print("we R in catch **************************************************");
    students=[];
    await connect();
    await initdb();
    for (var i = 1; i < clarifyfield.length; i++) {
      students.add(new Student.make(
          null, clarifyfield[i][3], clarifyfield[i][2], 0, false, null));
    }
    students.forEach((value) {
      print("prenom: " + value.firstName);
    });
    Classroom c1 =
        new Classroom.make(null, basename, clarifyfield.length - 1, students);

    // // Insert some posts
    print('Inserting sample rows ...');
    int id1 = await cBean.insert(c1, cascade: true);
    print('Inserted successfully row with id: $id1 and one to many relation!');
  }
}

getAllByclassName(id) async {
  connect();
  List<Student> std = await sBean.findByClassroom(id);
  return std;
}

getPresencesByStudent(id) async {
  connect();
  List<Presence> p = await pBean.findByStudent(id);
  return p;
}

getAllClassrooms() async {
  connect();
  List<Classroom> classrooms = await cBean.findAll();
  return classrooms;
}

associatepToStd(Student std, Presence p) {
  connect();
  pBean.associateStd(p, std);
}

addPresence(List<Presence> p) async {
  connect();
  await pBean.insertMany(p);
}

updateStudent(Student std) async {
  connect();
  await sBean.update(std);
}
getStdById(id)async {
   Student std =await sBean.find(id);
   return std;
}

removePresence(id) async {
  connect();
  await pBean.remove(id);
}
