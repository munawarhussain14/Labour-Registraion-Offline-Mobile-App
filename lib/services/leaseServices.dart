import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:cmlw_labour_registration/database/db.dart';
import 'package:cmlw_labour_registration/models/lease.dart';
import 'package:flutter/material.dart';

class LeaseService extends DB {
  LeaseService() {
    //createMineralTitleTable();
  }

  @override
  Future<dynamic> create(dynamic table) async {
    final db = await DB.instance.database;
    final Map<String, dynamic> json = {
      "code": table.code,
      "parties": table.parties,
      "district": table.district,
      "minerals": table.minerals
    };
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
    if (maps.isNotEmpty) {
      return Lease.fromJson(maps.first);
    } else {
      return null;
      throw Exception('ID $id not found');
    }
  }

  Future<List<dynamic>> readAll() async {
    final db = await DB.instance.database;

    final orderBy = '${LeaseFields.code} ASC';

    final result = await db.query(tableLease, orderBy: orderBy);

    return result.map((json) => Lease.fromJson(json)).toList();
  }

  Future<List<dynamic>> getByDistrict(String keyword, String district) async {
    final db = await DB.instance.database;

    final orderBy = '${LeaseFields.code} ASC';

    final result = await db.rawQuery(
        "select code, minerals, district, parties from ${tableLease} where district='${district}' or minerals like '%${keyword}%' or code like '%${keyword}%' or parties like '%${keyword}%' order by id");

    return result.map((json) => Lease.fromJson(json)).toList();
  }

  Future<List<dynamic>> getDistricts() async {
    final db = await DB.instance.database;

    final orderBy = '${LeaseFields.code} ASC';

    final result = await db.rawQuery(
        "select distinct district from ${tableLease} order by district");

    return result.map((json) => Lease.fromJson(json)).toList();
  }

  Future<int> deleteAll() async {
    final db = await DB.instance.database;

    return await db.delete(tableLease);
  }

  Future<int> update(dynamic table) async {
    final db = await DB.instance.database;

    return db.update(tableLease, table.toJson(),
        where: '${LeaseFields.id}= ?', whereArgs: [table.id]);
  }

  Future<int> delete(int id) async {
    final db = await DB.instance.database;

    return await db
        .delete(tableLease, where: '${LeaseFields.id}= ?', whereArgs: [id]);
  }
}
