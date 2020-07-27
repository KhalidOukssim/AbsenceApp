import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import 'student.dart';
part 'presence.jorm.dart';


// The model
class Presence {
  Presence();

  Presence.make(this.id, this.present, this.at,this.note);

  @PrimaryKey(auto: true)
  int id;
  @Column(isNullable: true)
  bool present;
  @Column(isNullable: true)
  DateTime at;
  @Column(isNullable: true)
  String note;


  @BelongsTo(StudentBean)
  int studentId;

  String toString() => 'presence(id: $id, present: $present, at: $at)';
}

 @GenBean()
 class PresenceBean extends Bean<Presence> with _PresenceBean {
  StudentBean _studentBean;

   StudentBean get studentBean => _studentBean ??= new StudentBean(adapter);

   PresenceBean(Adapter adapter) : super(adapter);

   final String tableName = 'presence';
 }
