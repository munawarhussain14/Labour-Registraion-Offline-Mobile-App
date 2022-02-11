import 'dart:async';

import 'package:cmlw_labour_registration/models/area.dart';
import 'package:cmlw_labour_registration/models/district.dart';
import 'package:cmlw_labour_registration/models/labour.dart';
import 'package:cmlw_labour_registration/models/lease.dart';
import 'package:cmlw_labour_registration/models/work_type.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:cmlw_labour_registration/services/districtServices.dart';
import 'package:cmlw_labour_registration/services/leaseServices.dart';
import 'package:cmlw_labour_registration/services/workTypeServices.dart';
import 'package:csv/csv.dart';

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
        '${LabourFields.work_type} $textType,'
        '${LabourFields.perm_address} $textType NOT NULL,'
        '${LabourFields.perm_district_name} $textType NOT NULL,'
        '${LabourFields.perm_district} $numberType NOT NULL,'
        '${LabourFields.area_id} $numberType NOT NULL,'
        '${LabourFields.area_name} $numberType NOT NULL,'
        '${LabourFields.lease_code} $textType NOT NULL,'
        '${LabourFields.createTime} $textType NOT NULL)';

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

    syncDistrict();
    syncWorkType();
    syncMineralTitle();
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

  Future<String> loadDistrictAsset() async {
    return await rootBundle.loadString('assets/csv/districts.csv');
  }

  void syncDistrict() async
  {
    List<List<dynamic>> rows = const CsvToListConverter().convert(await loadDistrictAsset());
    DistrictService service = new DistrictService();
    rows.asMap().forEach((index,element) async {
      if(index>0){
        await service.create(District.fromJson({"id":element[0],"name":element[1],"province":element[1]}));
      }
    });
  }

  Future<String> loadMineralTitleAsset() async {
    return await rootBundle.loadString('assets/csv/lease.csv');
  }

  void syncMineralTitle() async
  {
    List<List<dynamic>> rows = const CsvToListConverter().convert(await loadMineralTitleAsset()).toList();
    print(rows.length);
    LeaseService service = new LeaseService();
    rows.asMap().forEach((index,element) async {
      if(index>0){
        Lease temp = await service.create(Lease.fromJson({
          "code":element[0],
          "parties":element[1],
          "rsp_office":element[2],
          "type_group":element[3],
          "type":element[4],
          "mineral_group":element[7],
          "minerals":element[6],
          "district":element[8],
          "grant_date":element[9],
          "expiry_date":element[10]
        }));
      }
    });
  }

  Future<String> loadWorkTypeAsset() async {
    return await rootBundle.loadString('assets/csv/work_types.csv');
  }

  void syncWorkType() async
  {
    List<List<dynamic>> rows = const CsvToListConverter().convert(await loadWorkTypeAsset()).toList();
    WorkTypeService service = new WorkTypeService();
    //print(await service.getTables());

    rows.asMap().forEach((index,element) async {
      if(index>0){
        WorkType temp = await service.create(WorkType.fromJson({
          "id":element[0],
          "name":element[1]
        }));
      }
    });
  }

}
