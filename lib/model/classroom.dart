import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import 'student.dart';
part 'classroom.jorm.dart';

// The model
class Classroom {
  Classroom();

  Classroom.make(this.id, this.className, this.nStudents ,this.students);

  @PrimaryKey(auto: true)
  int id;

  @Column(isNullable: true)
  String className;

  @Column(isNullable: true)
  int nStudents;

  @HasMany(StudentBean)
  List<Student> students;

  //@HasMany(ItemBean)
  //List<Item> items;

  String toString() =>
      'Classroom(id: $id, className: $className, nStudent: $nStudents, students: $students)';
}

@GenBean()
class ClassroomBean extends Bean<Classroom> with _ClassroomBean {
  ClassroomBean(Adapter adapter)
      : studentBean = StudentBean(adapter),
        super(adapter);

  final StudentBean studentBean;

  Future<int> updateNameField(int id, String name) async {
    Update st = updater.where(this.id.eq(id)).set(this.className, name);
     return adapter.update(st);
   }

  final String tableName = 'classrooms';
}
