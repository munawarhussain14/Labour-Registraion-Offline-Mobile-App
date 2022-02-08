import 'dart:core';

final String tableArea = 'mine_area';

class AreaFields {
  static final String id = "id";
  static final String name = "name";
  static final String lease_code = "lease_code";

  static final List<String> values = [id, name, lease_code];
}

class Area {
  late int? id;
  late String? name;
  late String? lease_code;

  Area({this.id, this.name, this.lease_code});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
        id: json["id"], name: json["name"], lease_code: json["lease_code"]);
  }

  Map<String, dynamic?> toJson() {
    Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (lease_code != null) data['lease_code'] = lease_code;
    return data;
  }

  Area copy({int? id, String? name, String? lease_code}) => Area(
      id: id ?? this.id,
      name: name ?? this.name,
      lease_code: lease_code ?? this.lease_code);
}
