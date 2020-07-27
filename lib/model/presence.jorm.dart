

part of 'presence.dart';



abstract class _PresenceBean implements Bean<Presence> {
  final id = new IntField('id');
  final present = new BoolField('present');
  final at = new DateTimeField('at');
  final note = new StrField('note');
  final studentId = new IntField('student_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        present.name: present,
        at.name: at,
        note.name: note,
        studentId.name:studentId
      };
  Presence fromMap(Map map) {
    Presence model = new Presence();

    model.id = adapter.parseValue(map['id']);
    model.present = adapter.parseValue(map['present']);
    model.at = adapter.parseValue(map['at']);
    model.note = adapter.parseValue(map['note']);
    model.studentId = adapter.parseValue(map['student_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Presence model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(present.set(model.present));
      ret.add(at.set(model.at));
      ret.add(note.set(model.note));
      ret.add(studentId.set(model.studentId));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(present.name)) ret.add(present.set(model.present));
      if (only.contains(at.name)) ret.add(at.set(model.at));
      if (only.contains(note.name)) ret.add(note.set(model.note));
      if (only.contains(studentId.name)) ret.add(studentId.set(model.studentId));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addBool(present.name, isNullable: true);
    st.addDateTime(at.name, isNullable: true);
    st.addStr(note.name,isNullable: true);
    st.addInt(studentId.name,
        foreignTable: studentBean.tableName, foreignCol: 'id', isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Presence model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Presence> models) async {
    final List<List<SetColumn>> data =
        models.map((model) => toSetColumns(model)).toList();
    final InsertMany insert = inserters.addAll(data);
    return adapter.insertMany(insert);
  }

   Future<int> update(Presence model, {Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Presence> models) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
      where.add(this.id.eq(model.id));
    }
    final UpdateMany update = updaters.addAll(data, where);
    return adapter.updateMany(update);
  }

  Future<Presence> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Presence> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<List<Presence>> findByStudent(int studentId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.studentId.eq(studentId));
    return findMany(find);
  }

  Future<int> removeByStudent(int studentId) async {
    final Remove rm = remover.where(this.studentId.eq(studentId));
    return await adapter.remove(rm);
  }
  Future<List<Presence>> findByStudentList(List<Student> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (Student model in models) {
      find.or(this.studentId.eq(model.id));
    }
    return findMany(find);
  }


  void associateStd(Presence child, Student parent) {
    child.studentId = parent.id;
  }

  StudentBean get studentBean;
}
