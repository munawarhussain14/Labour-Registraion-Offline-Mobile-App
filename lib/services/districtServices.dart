import 'dart:core';

import 'package:cmlw_labour_registration/database/db.dart';
import 'package:cmlw_labour_registration/models/district.dart';

class DistrictService extends DB{

  @override
  Future<dynamic> create(dynamic table) async {
    final db = await DB.instance.database;

    final json = table.toJson();
    final id = await db.insert(tableDistrict, table.toJson());

    return table.copy(id: id);
  }

  @override
  Future<dynamic?> read(int id) async {
    final db = await DB.instance.database;

    final maps = await db.query(tableDistrict,
        columns: DistrictFields.values,
        where: '${DistrictFields.id}= ?',
        whereArgs: [id]);
    if(maps.isNotEmpty){
      return District.fromJson(maps.first);
    }else{
      return null;
      throw Exception('ID $id not found');
    }
  }

  Future<List<dynamic>> readAll() async{
    final db = await DB.instance.database;

    final orderBy = '${DistrictFields.name} ASC';

    final result = await db.query(tableDistrict,orderBy:orderBy);

    return result.map((json)=>District.fromJson(json)).toList();
  }

  Future<int> deleteAll() async{
    final db = await DB.instance.database;

    return await db.delete(
        tableDistrict
    );
  }

  Future<int> update(dynamic table) async{
    final db = await DB.instance.database;

    return db.update(tableDistrict, table.toJson(),
        where: '${DistrictFields.id}= ?',
        whereArgs: [table.id]);
  }

  Future<int> delete(int id) async{
    final db = await DB.instance.database;

    return await db.delete(
        tableDistrict,
        where: '${DistrictFields.id}= ?',
        whereArgs: [id]
    );
  }
}