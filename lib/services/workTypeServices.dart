import 'dart:core';

import 'package:cmlw_labour_registration/database/db.dart';
import 'package:cmlw_labour_registration/models/work_type.dart';

class WorkTypeService extends DB {
  @override
  Future<dynamic> create(dynamic table) async {
    final db = await DB.instance.database;
    print(table.toJson());
    final id = await db.insert(tableWorkType, {"id":table.id, "name":table.name});

    return table.copy(id: id);
  }

  @override
  Future<dynamic?> read(int id) async {
    final db = await DB.instance.database;

    final maps = await db.query(tableWorkType,
        columns: WorkTypeFields.values,
        where: '${WorkTypeFields.id}= ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return WorkType.fromJson(maps.first);
    } else {
      return null;
      throw Exception('ID $id not found');
    }
  }

  /*
  Future<List<dynamic>> readWhere() async {
    final db = await DB.instance.database;

    final orderBy = '${DistrictFields.name} ASC';

    final result = await db.query(tableDistrict,
        orderBy: orderBy,
        where: '${DistrictFields.id}= ?',
        whereArgs: [id]);

    return result.map((json) => District.fromJson(json)).toList();
  }*/

  Future<List<dynamic>> readAll() async {
    final db = await DB.instance.database;

    final orderBy = '${WorkTypeFields.name} ASC';

    final result = await db.query(tableWorkType, orderBy: orderBy);

    return result.map((json) => WorkType.fromJson(json)).toList();
  }

  Future<int> deleteAll() async {
    final db = await DB.instance.database;

    return await db.delete(tableWorkType);
  }

  Future<int> update(dynamic table) async {
    final db = await DB.instance.database;

    return db.update(tableWorkType, table.toJson(),
        where: '${WorkTypeFields.id}= ?', whereArgs: [table.id]);
  }

  Future<int> delete(int id) async {
    final db = await DB.instance.database;

    return await db.delete(tableWorkType,
        where: '${WorkTypeFields.id}= ?', whereArgs: [id]);
  }

  Future<dynamic> getTables() async {
    final db = await DB.instance.database;

    final result = await db.rawQuery(
        "SELECT * FROM sqlite_master where name = 'work_type' ORDER BY name;");

    return result;
  }
}
