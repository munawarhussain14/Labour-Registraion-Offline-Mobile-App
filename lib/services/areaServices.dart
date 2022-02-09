import 'dart:core';

import 'package:cmlw_labour_registration/database/db.dart';
import 'package:cmlw_labour_registration/models/area.dart';

class AreaService extends DB {
  @override
  Future<dynamic> create(dynamic table) async {
    final db = await DB.instance.database;

    final json = table.toJson();
    final id = await db.insert(tableArea, table.toJson());

    return table.copy(id: id);
  }

  @override
  Future<dynamic?> read(int id) async {
    final db = await DB.instance.database;

    final maps = await db.query(tableArea,
        columns: AreaFields.values,
        where: '${AreaFields.id}= ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Area.fromJson(maps.first);
    } else {
      return null;
      throw Exception('ID $id not found');
    }
  }

  Future<List<dynamic>> readAll() async {

    final db = await DB.instance.database;

    final orderBy = '${AreaFields.name} ASC';

    final result = await db.query(tableArea, orderBy: orderBy);

    return result.map((json) => Area.fromJson(json)).toList();
  }

  Future<List<dynamic>> readWhere(String condition) async {

    final db = await DB.instance.database;

    final orderBy = '${AreaFields.name} ASC';

    final result = await db.query(tableArea,where: condition, orderBy: orderBy);

    return result.map((json) => Area.fromJson(json)).toList();
  }

  Future<int> deleteAll() async {
    final db = await DB.instance.database;

    return await db.delete(tableArea);
  }

  Future<int> update(dynamic table) async {
    final db = await DB.instance.database;

    return db.update(tableArea, table.toJson(),
        where: '${AreaFields.id}= ?', whereArgs: [table.id]);
  }

  Future<int> delete(int id) async {
    final db = await DB.instance.database;

    return await db.delete(tableArea,
        where: '${AreaFields.id}= ?', whereArgs: [id]);
  }
}
