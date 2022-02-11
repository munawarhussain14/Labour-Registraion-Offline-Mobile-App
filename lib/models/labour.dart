import 'dart:core';

final String tableLabour = 'labours';

class LabourFields {
  static final String id = "id";
  static final String purpose = "purpose";
  static final String name = "name";
  static final String cnic = "cnic";
  static final String father_name = "father_name";
  static final String doa = "doa";
  static final String cell_no_primary = "cell_no_primary";
  static final String cell_no_secondary = "cell_no_secondary";
  static final String gender = "gender";
  static final String married = "married";
  static final String eobi = "eobi";
  static final String eobi_no = "eobi_no";
  static final String work_from = "work_from";
  static final String work_type = "work_type";
  static final String perm_address = "perm_address";
  static final String perm_district_name = "perm_district_name";
  static final String perm_district = "perm_district";
  static final String area_id = "area_id";
  static final String area_name = "area_name";
  static final String lease_code = "lease_code";
  static final String createTime = "createTime";

  static final List<String> values = [
    id,
    purpose,
    name,
    cnic,
    father_name,
    doa,
    cell_no_primary,
    cell_no_secondary,
    gender,
    married,
    eobi,
    eobi_no,
    work_from,
    work_type,
    perm_address,
    perm_district_name,
    perm_district,
    area_id,
    area_name,
    lease_code,
    createTime
  ];
}

class Labours {
  final int status;
  final String message;
  final List<Labour> data;

  Labours({required this.status, required this.message, required this.data});

  factory Labours.fromJson(Labour labourJson) {
    List list = labourJson as List;
    List<Labour> labours = list.map((e) {
      return Labour.fromJson(e);
    }).toList();
    return Labours(status: 200, message: "Labours", data: labours);
  }
}

class Labour {
  late int? id;
  late String? purpose;
  late String? name;
  late String? cnic;
  late String? father_name;
  late String? doa;
  late String? cell_no_primary;
  late String? cell_no_secondary;
  late String? gender;
  late String? married;
  late String? eobi;
  late String? eobi_no;
  late String? work_from;
  late String? work_type;
  late String? perm_address;
  late String? perm_district_name;
  late int? perm_district;
  late int? area_id;
  late String? area_name;
  late String? lease_code;
  late String? createTime;

  Labour(
      {this.id,
      this.purpose,
      this.name,
      this.cnic,
      this.father_name,
      this.doa,
      this.cell_no_primary,
      this.cell_no_secondary,
      this.gender,
      this.married,
      this.eobi,
      this.eobi_no,
      this.work_from,
      this.work_type,
      this.perm_address,
      this.perm_district_name,
      this.perm_district,
      this.area_id,
      this.area_name,
      this.lease_code,
        this.createTime});

  Labour copy(
          {int? id,
          String? purpose,
          String? name,
          String? cnic,
          String? father_name,
          String? doa,
          String? cell_no_primary,
          String? cell_no_secondary,
          String? gender,
          String? married,
          String? eobi,
          String? eobi_no,
          String? work_from,
          String? work_type,
          String? perm_address,
          String? perm_district_name,
          int? perm_district,
          int? area_id,
          String? area_name,
          String? lease_code,
            String? createTime}) =>
      Labour(
          id: id ?? this.id,
          purpose: purpose ?? this.purpose,
          name: name ?? this.name,
          cnic: cnic ?? this.cnic,
          father_name: father_name ?? this.father_name,
          doa: doa ?? this.doa,
          cell_no_primary: cell_no_primary ?? this.cell_no_primary,
          cell_no_secondary: cell_no_secondary ?? this.cell_no_secondary,
          gender: gender ?? this.gender,
          married: married ?? this.married,
          eobi: eobi ?? this.eobi,
          eobi_no: eobi_no ?? this.eobi_no,
          work_from: work_from ?? this.work_from,
          work_type: work_type ?? this.work_type,
          perm_address: perm_address ?? this.perm_address,
          perm_district_name: perm_district_name ?? this.perm_district_name,
          perm_district: perm_district ?? this.perm_district,
          area_id: area_id?? this.area_id,
          area_name: area_name?? this.area_name,
          lease_code: lease_code?? this.lease_code,
          createTime:createTime??this.createTime);

  factory Labour.fromJson(Map<String, dynamic> json) {

    return Labour(
        id: json["id"],
        purpose: json["purpose"],
        name: json["name"],
        cnic: json["cnic"],
        father_name: json["father_name"],
        doa: json["doa"],
        cell_no_primary: json["cell_no_primary"],
        cell_no_secondary: json["cell_no_secondary"],
        gender: json["gender"],
        married: json["married"],
        eobi: json["eobi"],
        eobi_no: json["eobi_no"],
        work_from: json["work_from"],
        work_type: json["work_type"],
        perm_address: json["perm_address"],
        perm_district_name: json["perm_district_name"],
        perm_district: json["perm_district"],
        area_id: json["area_id"],
        area_name: json["area_name"],
        lease_code: json["lease_code"],
        createTime: json["createTime"]);
  }

  Map<String, dynamic?> toJson() {
    Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (purpose != null) data['purpose'] = purpose;
    if (name != null) data['name'] = name;
    if (cnic != null) data['cnic'] = cnic;
    if (father_name != null) data['father_name'] = father_name;
    if (doa != null) data['doa'] = doa;
    if (cell_no_primary != null) data['cell_no_primary'] = cell_no_primary;
    if (cell_no_secondary != null) data['cell_no_secondary'] = cell_no_secondary;
    if (gender != null) data['gender'] = gender;
    if (married != null) data['married'] = married;
    if (eobi != null) data['eobi'] = eobi;
    if (eobi_no != null) data['eobi_no'] = eobi_no;
    if (work_from != null) data['work_from'] = work_from;
    if (work_type != null) data['work_type'] = work_type;
    if (perm_address != null) data['perm_address'] = perm_address;
    if (perm_district_name != null) data['perm_district_name'] = perm_district_name;
    if (perm_district != null) data['perm_district'] = perm_district;
    if (area_id != null) data['area_id'] = area_id;
    if (area_name != null) data['area_name'] = area_name;
    if (lease_code != null) data['lease_code'] = lease_code;
    if (createTime != null) data['createTime'] = createTime;
    return data;
  }
}
