import 'dart:core';

final String tableWorkType = 'work_type';

class WorkTypeFields{
  static final String id = "id";
  static final String name = "name";

  static final List<String> values = [id, name];
}

class WorkType{
  late int? id;
  late String? name;

  WorkType({
    this.id,
    this.name
  });

  factory WorkType.fromJson(Map<String, dynamic> json){
    return WorkType(
        id:json["id"],
        name:json["name"],
    );
  }

  Map<dynamic, dynamic> toJson(){
    Map<dynamic,dynamic> data = {};
    if(id!=null)
      data['id'] = id;
    if(name!=null)
      data['name'] = name;
    return data;
  }

  WorkType copy({int? id, String? name}) => WorkType(
      id: id ?? this.id,
      name: name ?? this.name);

}