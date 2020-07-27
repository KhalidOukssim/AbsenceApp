// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************



abstract class _StudentBean implements Bean<Student> {
  final id = new IntField('id');
  final firstName = new StrField('firstName');
  final lastName = new StrField('lastName');
  final nAbsences = new IntField('nAbsences');
  final isPr = new BoolField('isPr');
  final classroomId = new IntField('classroom_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        firstName.name: firstName,
        lastName.name: lastName,
        nAbsences.name:nAbsences,
        isPr.name:isPr,
        classroomId.name: classroomId
      };
  Student fromMap(Map map) {
    Student model = new Student();

    model.id = adapter.parseValue(map['id']);
    model.firstName = adapter.parseValue(map['firstName']);
    model.lastName = adapter.parseValue(map['lastName']);
    model.nAbsences = adapter.parseValue(map['nAbsences']);
    model.isPr = adapter.parseValue(map['isPr']);
    model.classroomId = adapter.parseValue(map['classroom_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Student model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(firstName.set(model.firstName));
      ret.add(lastName.set(model.lastName));
      ret.add(nAbsences.set(model.nAbsences));
      ret.add(isPr.set(model.isPr));
      ret.add(classroomId.set(model.classroomId));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(firstName.name)) ret.add(firstName.set(model.firstName));
      if (only.contains(lastName.name)) ret.add(lastName.set(model.lastName));
      if (only.contains(nAbsences.name)) ret.add(nAbsences.set(model.nAbsences));
      if (only.contains(isPr.name)) ret.add(isPr.set(model.isPr));
      if (only.contains(classroomId.name)) ret.add(classroomId.set(model.classroomId));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(firstName.name, isNullable: true);
    st.addStr(lastName.name, isNullable: true);
    st.addInt(nAbsences.name, isNullable: true);
    st.addBool(isPr.name, isNullable: true);
    st.addInt(classroomId.name,
        foreignTable: classroomBean.tableName, foreignCol: 'id', isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Student model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model))..id(id.name);
    final ret = await adapter.insert(insert);
    if (cascade) {
      Student newModel;
      if (model.presences != null) {
        newModel ??= await find(ret);
        model.presences.forEach((x) => presenceBean.associateStd(x, newModel));
        for (final child in model.presences) {
          await presenceBean.insert(child);
        }
      }
    }
    return ret;
  }

  Future<void> insertMany(List<Student> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(insert(model, cascade: cascade));
      }
      return Future.wait(futures);
    } else {
      final List<List<SetColumn>> data =
          models.map((model) => toSetColumns(model)).toList();
      final InsertMany insert = inserters.addAll(data);
      return adapter.insertMany(insert);
    }
  }

  Future<int> update(Student model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      Student newModel;
      if (model.presences != null) {
        if (associate) {
          newModel ??= await find(model.id);
          model.presences.forEach((x) => presenceBean.associateStd(x, newModel));
        }
        for (final child in model.presences) {
          await presenceBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<Student> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(update(model, cascade: cascade));
      }
      return Future.wait(futures);
    } else {
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
  }

  Future<Student> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Student model = await findOne(find);
    if (preload) {
      await this.preload(model, cascade: cascade);
    }
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Student> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<List<Student>> findByClassroom(int classroomId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.classroomId.eq(classroomId));
    return findMany(find);
  }


  Future<List<Student>> findByClassroomList(List<Classroom> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (Classroom model in models) {
      find.or(this.classroomId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByClassroom(int classroomId) async {
    final Remove rm = remover.where(this.classroomId.eq(classroomId));
    return await adapter.remove(rm);
  }

  void associateClassroom(Student child, Classroom parent) {
    child.classroomId = parent.id;
  }


  Future<Student> preload(Student model, {bool cascade: false}) async {
    model.presences =
        await presenceBean.findByStudent(model.id, preload: cascade, cascade: cascade);
    return model;
  }

  Future<List<Student>> preloadAll(List<Student> models,
      {bool cascade: false}) async {
    models.forEach((Student model) => model.presences ??= []);
    await OneToXHelper.preloadAll<Student, Presence>(
        models,
        (Student model) => [model.id],
        presenceBean.findByStudentList,
        (Presence model) => [model.studentId],
        (Student model, Presence child) => model.presences.add(child),
        cascade: cascade);
    return models;
  }
  
  PresenceBean get presenceBean;
  ClassroomBean get classroomBean;

}
