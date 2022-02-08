import 'dart:async';

import 'package:cmlw_labour_registration/models/area.dart';
import 'package:cmlw_labour_registration/models/district.dart';
import 'package:cmlw_labour_registration/models/labour.dart';
import 'package:cmlw_labour_registration/models/lease.dart';
import 'package:cmlw_labour_registration/models/work_type.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {

  DB();

  static final DB instance = DB._init();

  static Database? _database;

  static String db_name = "dev_labour.db";

  DB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(db_name);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB );
  }

  Future removeDatabase()async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, db_name);

    await deleteDatabase(path);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';
    final boolType = 'BOOLEAN';
    final numberType = 'INTEGER';

    String sql = 'CREATE TABLE $tableLabour('
        '${LabourFields.id} $idType,'
        '${LabourFields.purpose} $textType NOT NULL,'
        '${LabourFields.name} $textType NOT NULL,'
        '${LabourFields.cnic} $textType NOT NULL,'
        '${LabourFields.father_name} $textType NOT NULL,'
        '${LabourFields.doa} $textType NOT NULL,'
        '${LabourFields.cell_no_primary} $textType NOT NULL,'
        '${LabourFields.cell_no_secondary} $textType,'
        '${LabourFields.gender} $textType NOT NULL,'
        '${LabourFields.married} $textType NOT NULL,'
        '${LabourFields.eobi} $textType,'
        '${LabourFields.eobi_no} $textType,'
        '${LabourFields.work_from} $textType NOT NULL,'
        '${LabourFields.work_type} $numberType,'
        '${LabourFields.perm_address} $textType NOT NULL,'
        '${LabourFields.perm_district} $numberType NOT NULL)';
    await db.execute(sql);

    sql = 'CREATE TABLE $tableLease('
        '${LeaseFields.id} $idType,'
        '${LeaseFields.code} $textType NOT NULL,'
        '${LeaseFields.parties} $textType NOT NULL,'
        '${LeaseFields.rsp_office} $textType,'
        '${LeaseFields.type_group} $textType,'
        '${LeaseFields.type} $textType,'
        '${LeaseFields.mineral_group} $textType,'
        '${LeaseFields.minerals} $textType NOT NULL,'
        '${LeaseFields.district} $textType NOT NULL,'
        '${LeaseFields.grant_date} $textType,'
        '${LeaseFields.expiry_date} $textType,'
        '${LeaseFields.area} $textType,'
        '${LeaseFields.unit} $textType'
        ')';
    await db.execute(sql);

    sql = 'CREATE TABLE $tableDistrict('
        '${DistrictFields.id} $idType,'
        '${DistrictFields.name} $textType NOT NULL,'
        '${DistrictFields.province} $textType NOT NULL)';
    await db.execute(sql);

    sql = 'CREATE TABLE $tableArea('
        '${AreaFields.id} $idType,'
        '${AreaFields.name} $textType NOT NULL,'
        '${AreaFields.lease_code} $textType NOT NULL)';
    await db.execute(sql);

    sql = 'CREATE TABLE $tableWorkType('
        '${WorkTypeFields.id} $idType,'
        '${WorkTypeFields.name} $textType NOT NULL)';
    await db.execute(sql);
  }

  Future createMineralTitleTable()async{
    final db = await instance.database;
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final numberType = 'INTEGER NOT NULL';

    String sql = 'CREATE TABLE $tableLease('
        '${LeaseFields.id} $idType,'
        '${LeaseFields.code} $textType,'
        '${LeaseFields.parties} $textType,'
        '${LeaseFields.rsp_office} $textType,'
        '${LeaseFields.type_group} $textType,'
        '${LeaseFields.type} $textType,'
        '${LeaseFields.mineral_group} $textType,'
        '${LeaseFields.minerals} $textType,'
        '${LeaseFields.district} $textType,'
        '${LeaseFields.grant_date} $textType,'
        '${LeaseFields.expiry_date} $textType,'
        '${LeaseFields.area} $textType,'
        '${LeaseFields.unit} $textType'
        ')';
    //await db.execute('DROP TABLE $tableLease');
    return await db.execute(sql);
  }

  Future<dynamic> create(dynamic table) async {
    final db = await instance.database;

    final json = table.toJson();
    //final columns = '${LabourFields.id},${LabourFields.name}';
    //final values = '${json[LabourFields.id]},${json[LabourFields.name]}';
    //final id = await db.rawInsert(sql);
    final id = await db.insert(tableLabour, table.toJson());

    return table.copy(id: id);
  }

  Future<dynamic?> read(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableLabour,
        columns: LabourFields.values,
        where: '${LabourFields.id}= ?',
        whereArgs: [id]);

    if(maps.isNotEmpty){
      return Labour.fromJson(maps.first);
    }else{
      return null;
      throw Exception('ID $id not found');
    }
  }

  Future<List<dynamic>> readAll() async{
    final db = await instance.database;

    final orderBy = '${LabourFields.createTime} ASC';

    final result = await db.query(tableLabour,orderBy: orderBy);

    return result.map((json)=>Labour.fromJson(json)).toList();
  }

  Future<int> update(Labour labour) async{
    final db = await instance.database;

    return db.update(tableLabour, labour.toJson(),
        where: '${LabourFields.id}= ?',
        whereArgs: [labour.id]);
  }

  Future<int> delete(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableLabour,
        where: '${LabourFields.id}= ?',
        whereArgs: [id]
    );
  }

  Future<int> deleteAll() async{
    final db = await instance.database;

    return await db.delete(
        tableLabour
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
