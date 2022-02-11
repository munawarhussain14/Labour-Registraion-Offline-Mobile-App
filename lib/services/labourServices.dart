import 'dart:core';

import 'package:cmlw_labour_registration/database/db.dart';
import 'package:cmlw_labour_registration/models/labour.dart';

class LabourService extends DB {
  @override
  Future<dynamic> create(dynamic table) async {
    final db = await DB.instance.database;

    final id = await db.insert(tableLabour, table.toJson());
    return table.copy(id: id);
  }

  @override
  Future<dynamic?> read(int id) async {
    final db = await DB.instance.database;

    final maps = await db.query(tableLabour,
        columns: LabourFields.values,
        where: '${LabourFields.id}= ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Labour.fromJson(maps.first);
    } else {
      return null;
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<dynamic?> readByCNIC(String cnic) async {
    final db = await DB.instance.database;

    final maps = await db.query(tableLabour,
        columns: LabourFields.values,
        where: '${LabourFields.cnic}= ?',
        whereArgs: [cnic]);
    if (maps.isNotEmpty) {
      return Labour.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<dynamic>> readAll() async {

    final db = await DB.instance.database;

    final orderBy = '${LabourFields.name} ASC';

    final result = await db.query(tableLabour,
        orderBy: orderBy);
    return result.map((json){return Labour.fromJson(json);}).toList();
  }

  Future<List<List<dynamic>>> exportList() async {

    final db = await DB.instance.database;

    final orderBy = '${LabourFields.name} ASC';

    final result = await db.query(tableLabour,
        orderBy: orderBy);

    return result.map((json){
      return [
        json["id"],
        json["name"],
        json["cnic"],
        json["father_name"],
        json["dob"],
        json["cell_no_primary"],
        json["cell_no_secondary"],
        json["married"],
        json["eobi"],
        json["eobi_no"],
        json["work_from"],
        json["work_type"],
        json["perm_address"],
        json["perm_district_name"],
        json["purpose"],
        json["gender"],
        json["area_name"],
        json["lease_code"],
        json["createTime"]
      ];}).toList();
  }

  Future<List<dynamic>> readWhere(String condition) async {

    final db = await DB.instance.database;

    final orderBy = '${LabourFields.name} ASC';

    final result = await db.query(tableLabour,where: condition, orderBy: orderBy);

    return result.map((json) => Labour.fromJson(json)).toList();
  }

  Future<int> deleteAll() async {
    final db = await DB.instance.database;

    return await db.delete(tableLabour);
  }

  Future<int> update(dynamic table) async {
    final db = await DB.instance.database;

    return db.update(tableLabour, table.toJson(),
        where: '${LabourFields.id}= ?', whereArgs: [table.id]);
  }

  Future<int> delete(int id) async {
    final db = await DB.instance.database;

    return await db.delete(tableLabour,
        where: '${LabourFields.id}= ?', whereArgs: [id]);
  }
}
