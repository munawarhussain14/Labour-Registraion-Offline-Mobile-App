import 'dart:core';

final String tableDistrict = 'districts';

class DistrictFields {
  static final String id = "id";
  static final String name = "name";
  static final String province = "province";

  static final List<String> values = [
    id,
    name,
    province
  ];
}

class District {
  late int? id;
  late String? name;
  late String? province;

  District({this.id, this.name, this.province});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
        id: json["id"], name: json["name"], province: json["province"]);
  }

  Map<String, dynamic?> toJson() {
    Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (province != null) data['province'] = province;
    return data;
  }

  District copy({int? id, String? name, String? province}) => District(
      id: id ?? this.id,
      name: name ?? this.name,
      province: province ?? this.province);
}
