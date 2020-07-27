// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************


abstract class _ClassroomBean implements Bean<Classroom> {
  final id = new IntField('id');
  final className = new StrField('className');
  final nStudents = new IntField('nStudents');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        className.name: className,
        nStudents.name: nStudents
      };
  Classroom fromMap(Map map) {
    Classroom model = new Classroom();

    model.id = adapter.parseValue(map['id']);
    model.className = adapter.parseValue(map['className']);
    model.nStudents = adapter.parseValue(map['nStudents']);
    return model;
  }

  List<SetColumn> toSetColumns(Classroom model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(className.set(model.className));
      ret.add(nStudents.set(model.nStudents));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(className.name)) ret.add(className.set(model.className));
      if (only.contains(nStudents.name)) ret.add(nStudents.set(model.nStudents));
    }
    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(className.name, isNullable: true);
    st.addInt(nStudents.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Classroom model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model))..id(id.name);
    final ret = await adapter.insert(insert);
    if (cascade) {
      Classroom newModel;
      if (model.students != null) {
        newModel ??= await find(ret);
        model.students.forEach((x) => studentBean.associateClassroom(x, newModel));
        for (final child in model.students) {
          await studentBean.insert(child);
        }
      }
    }
    return ret;
  }

  Future<void> insertMany(List<Classroom> models, {bool cascade: false}) async {
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

  Future<int> update(Classroom model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      Classroom newModel;
      if (model.students != null) {
        if (associate) {
          newModel ??= await find(model.id);
          model.students.forEach((x) => studentBean.associateClassroom(x, newModel));
        }
        for (final child in model.students) {
          await studentBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<Classroom> models, {bool cascade: false}) async {
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

  Future<Classroom> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Classroom model = await findOne(find);
    if (preload) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<List<Classroom>> findAll({bool preload: false, bool cascade: false}) async {
    final Find find = finder.gt('id', 0);
    final List<Classroom> model = await findMany(find);
    if (preload) {
      await this.preloadAll(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int id, [bool cascade = false]) async {
    if (cascade) {
      final Classroom newModel = await find(id);
      await studentBean.removeByClassroom(newModel.id);
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Classroom> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<Classroom> preload(Classroom model, {bool cascade: false}) async {
    model.students =
        await studentBean.findByClassroom(model.id, preload: cascade, cascade: cascade);
    return model;
  }

  Future<List<Classroom>> preloadAll(List<Classroom> models,
      {bool cascade: false}) async {
    models.forEach((Classroom model) => model.students ??= []);
    await OneToXHelper.preloadAll<Classroom, Student>(
        models,
        (Classroom model) => [model.id],
        studentBean.findByClassroomList,
        (Student model) => [model.classroomId],
        (Classroom model, Student child) => model.students.add(child),
        cascade: cascade);
    return models;
  }


StudentBean get studentBean;

 } 

