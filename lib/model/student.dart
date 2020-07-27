import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import 'classroom.dart';
import 'presence.dart';
part 'student.jorm.dart';

// The model
class Student {
  Student();

  Student.make(this.id, this.firstName, this.lastName,this.nAbsences,this.isPr,this.presences);

  @PrimaryKey(auto: true)
  int id;

  @Column(isNullable: true)
  String firstName;

  @Column(isNullable: true)
  String lastName;

  @Column(isNullable: true)
  int nAbsences;

  @Column(isNullable: true)
  bool isPr;

  @BelongsTo(ClassroomBean)
  int classroomId;

   @HasMany(StudentBean)
  List<Presence> presences;

  String toString() => 'student(id: $id, firstName: $firstName, lastName: $lastName,num des absence: $nAbsences,isPr:$isPr, presences:$presences)';
}

@GenBean()
class StudentBean extends Bean<Student> with _StudentBean {
  ClassroomBean _classroomBean;

  ClassroomBean get classroomBean => _classroomBean ??= new ClassroomBean(adapter);

  StudentBean(Adapter adapter)
      : presenceBean = PresenceBean(adapter),
        super(adapter);
        
  final PresenceBean presenceBean;

  final String tableName = 'students';

}
