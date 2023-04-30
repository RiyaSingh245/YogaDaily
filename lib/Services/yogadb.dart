import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/model.dart';

class YogaDatabase {
  static final YogaDatabase instance = YogaDatabase._init();
  static Database? _database;
  YogaDatabase._init();

  Future<Database> _initializeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDB("Yoga.db");
    return _database;
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
        CREATE TABLE ${YogaModel.yogaTable1}(
          ${YogaModel.idName} $idType,
          ${YogaModel.yogaName} $textType,
          ${YogaModel.yogaKeyWorkout} $intType,
          ${YogaModel.imageName} $textType,
          ${YogaModel.secondsOrNot} $boolType,
          ${YogaModel.secondsORtimes} $textType
        )
        ''');

    await db.execute('''
        CREATE TABLE ${YogaModel.yogaTable2}(
          ${YogaModel.idName} $idType,
          ${YogaModel.yogaName} $textType,
          ${YogaModel.yogaKeyWorkout} $intType,
          ${YogaModel.imageName} $textType,
          ${YogaModel.secondsOrNot} $boolType,
          ${YogaModel.secondsORtimes} $textType
        )
        ''');

    await db.execute('''
        CREATE TABLE ${YogaModel.yogaTable3}(
          ${YogaModel.idName} $idType,
          ${YogaModel.yogaName} $textType,
          ${YogaModel.yogaKeyWorkout} $intType,
          ${YogaModel.imageName} $textType,
          ${YogaModel.secondsOrNot} $boolType,
          ${YogaModel.secondsORtimes} $textType
        )
        ''');

    await db.execute('''
        CREATE TABLE ${YogaModel.yogaSummary}(
          ${YogaModel.idName} $idType,
          ${YogaModel.workOutName} $textType,
          ${YogaModel.bgimageName} $textType,
          ${YogaModel.yogaKey} $intType,
          ${YogaModel.timeTaken} $textType,
          ${YogaModel.noOfWorkOut} $textType
        )
        ''');
  }

  Future<Yoga?> insert(Yoga yoga, String tableName) async {
    final db = await instance.database;
    final id = await db!.insert(tableName, yoga.toJson());
    return yoga.copy(id: id);
  }

  Future<YogaSummary?> insertYogaSum(YogaSummary yogasum) async {
    final db = await instance.database;
    final id = await db!.insert(YogaModel.yogaSummary, yogasum.toJson());
    return yogasum.copy(id: id);
  }

  Future<List<Yoga>> readAllYoga(String tableName) async {
    final db = await instance.database;
    final orderBy = '${YogaModel.idName} ASC';
    final queryRes = await db!.query(tableName, orderBy: orderBy);
    return queryRes.map((json) => Yoga.fromJson(json)).toList();
  }

  Future<List<YogaSummary>> readAllYogaSum() async {
    final db = await instance.database;
    final orderBy = '${YogaModel.idName} ASC';
    final queryRes = await db!.query(YogaModel.yogaSummary, orderBy: orderBy);
    return queryRes.map((json) => YogaSummary.fromJson(json)).toList();
  }

  Future<Yoga?> readOneYoga(int id, String tableName) async {
    final db = await instance.database;
    final map = await db!.query(tableName,
        columns: YogaModel.yogaTable1ColumnName,
        where: '${YogaModel.idName} = ?',
        whereArgs: [id]);
    if (map.isNotEmpty) {
      return Yoga.fromJson(map.first);
    } else {
      return null;
    }
  }
}
