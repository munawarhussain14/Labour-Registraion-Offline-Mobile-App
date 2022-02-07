import 'dart:core';

import 'package:cmlw_labour_registration/database/db.dart';
import 'package:cmlw_labour_registration/models/lease.dart';

class LeaseService extends DB{

  @override
  Future<dynamic> create(dynamic table) async {
    final db = await DB.instance.database;

    final json = table.toJson();
    final id = await db.insert(tableLease, table.toJson());

    return table.copy(id: id);
  }

  @override
  Future<dynamic?> read(int id) async {
    final db = await DB.instance.database;

    final maps = await db.query(tableLease,
        columns: LeaseFields.values,
        where: '${LeaseFields.id}= ?',
        whereArgs: [id]);
    if(maps.isNotEmpty){
      return Lease.fromJson(maps.first);
    }else{
      return null;
      throw Exception('ID $id not found');
    }
  }

  Future<List<dynamic>> readAll() async{
    //createMineralTitleTable();
    final db = await DB.instance.database;

    final orderBy = '${LeaseFields.code} ASC';

    final result = await db.query(tableLease,orderBy:orderBy);

    return result.map((json)=>Lease.fromJson(json)).toList();
  }

  Future<int> deleteAll() async{
    final db = await DB.instance.database;

    return await db.delete(
        tableLease
    );
  }

  Future<int> update(dynamic table) async{
    final db = await DB.instance.database;

    return db.update(tableLease, table.toJson(),
        where: '${LeaseFields.id}= ?',
        whereArgs: [table.id]);
  }

  Future<int> delete(int id) async{
    final db = await DB.instance.database;

    return await db.delete(
        tableLease,
        where: '${LeaseFields.id}= ?',
        whereArgs: [id]
    );
  }
}