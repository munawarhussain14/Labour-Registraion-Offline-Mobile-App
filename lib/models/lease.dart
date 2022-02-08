import 'dart:core';

final String tableLease = 'mineral_titles';

class LeaseFields{
  static final String id = "id";
  static final String code = "code";
  static final String parties = "parties";
  static final String rsp_office = "rsp_office";
  static final String type_group = "type_group";
  static final String type = "type";
  static final String mineral_group = "mineral_group";
  static final String minerals = "minerals";
  static final String district = "district";
  static final String grant_date = "grant_date";
  static final String expiry_date = "expiry_date";
  static final String area = "area";
  static final String unit = "unit";

  static final List<String> values = [
    id,
    code,
    parties,
    rsp_office,
    type_group,
    type,
    mineral_group,
    minerals,
    district,
    grant_date,
    expiry_date,
    area,
    unit
  ];
}

class Lease{
  late int? id;
  late String? code;
  late String? parties;
  late String? res_office;
  late String? type_group;
  late String? type;
  late String? mineral_group;
  late String? minerals;
  late String? district;
  late String? grant_date;
  late String? expiry_date;
  late double? area;
  late String? unit;

  Lease({
    this.id,
    this.code,
    this.parties,
    this.res_office,
    this.type_group,
    this.type,
    this.mineral_group,
    this.minerals,
    this.district,
    this.grant_date,
    this.expiry_date,
    this.area,
    this.unit
  });

  factory Lease.fromJson(Map<String, dynamic> json){
    return Lease(
        id:json["id"],
        code:json["code"],
        parties:json["parties"],
        res_office:json["res_office"],
        type_group:json["type_group"],
        type:json["type"],
        mineral_group:json["mineral_group"],
        minerals:json["minerals"],
        district:json["district"],
        grant_date:json["grant_date"],
        expiry_date:json["expiry_date"],
        area:json["area"],
        unit:json["unit"]
    );
  }

  Map<String, dynamic> toJson(){
    Map<String,dynamic> data = {};
    if(id!=null)
      data['id'] = id;

    if(code!=null)
      data['code'] = code;

    if(parties!=null)
      data['parties'] = parties;

    if(res_office!=null)
      data['res_office'] = res_office;

    if(type_group!=null)
      data['type_group'] = type_group;

    if(type!=null)
      data['type'] = type;

    if(mineral_group!=null)
      data['mineral_group'] = mineral_group;

    if(minerals!=null)
      data['minerals'] = minerals;

    if(district!=null)
      data['district'] = district;

    if(grant_date!=null)
      data['grant_date'] = grant_date;

    if(expiry_date!=null)
      data['expiry_date'] = expiry_date;

    if(area!=null)
      data['area'] = area;

    if(unit!=null)
      data['unit'] = unit;

    //print("=======================");
    //print(data);
    //print("======================");
    return data;
  }

  Lease copy({int? id, String? name, String? province}) => Lease(
      id: id ?? this.id,
      code: code ?? this.code,
      district: province ?? this.district);

}