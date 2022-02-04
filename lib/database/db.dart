import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static final DB instance = DB._init();

  static Database? _database;

  DB._init();

  Future<Database> get database async{
    if(_database !=null)return _database!;

    _database = await _initDB('labour.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath)async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version)async{

  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }

  //late final database;

  /*
  DB() {
    database = openDatabase(
      join('labours_database.db'),
      // ignore: void_checks
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE labours(id INTEGER PRIMARY KEY, '
              'purpose TEXT, '
              'name TEXT, '
              'cnic TEXT,'
              'father_name TEXT,'
              'father_name TEXT,'
              'doa TEXT,'
              'cell_no_primary TEXT,'
              'cell_no_secondary TEXT,'
              'district_id TEXT,'
              'married TEXT,'
              'eobi TEXT,'
              'eobi_no TEXT,'
              'work_start_from TEXT,'
              'work_type TEXT,'
              'perm_address TEXT,'
              'perm_district TEXT,'
              ')',
        );

        db.execute(
          'CREATE TABLE districts(id INTEGER PRIMARY KEY, '
              'name TEXT, '
              'province TEXT, '
              'assign_id TEXT,'
              ')',
        );
        return db;
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }*/
}
