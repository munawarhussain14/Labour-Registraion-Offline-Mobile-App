import 'dart:core';


final String tableLabour = '';
/*class Labours{
  final int status;
  final String message;
  final List<Labour> data;

  Labours({required this.status,required this.message, required this.data});

  factory Labours.fromJson(Labour labourJson){
    List list = labourJson as List;
    List<Labour> labours = list.map((e){return Labour.fromJson(e);}).toList();
    return Labours(status:200,message:"Labours",data:labours);
  }

}

class Labour{
  late int? id;
  late String? purpose;
  late String? name;
  late String? cnic;
  late String? father_name;
  late DateTime? doa;
  late String? cell_no_primary;
  late String? cell_no_secondary;
  late String? gender;
  late int? domicile_district;
  late int? district_id;
  late String? married;
  late String? eobi;
  late String? eobi_no;
  late DateTime? work_from;
  late int? work_type;
  late String? perm_address;
  late int? perm_district;

  Labour({
    this.id,
    this.purpose,
    this.name,
    this.cnic,
    this.father_name,
    this.doa,
    this.cell_no_primary,
    this.cell_no_secondary,
    this.gender,
    this.domicile_district,
    this.district_id,
    this.married,
    this.eobi,
    this.eobi_no,
    this.work_from,
    this.work_type,
    this.perm_address,
    this.perm_district
});

  factory Labour.fromJson(Map<String, dynamic> json){
    return Labour(
        id:json["id"],
        purpose:json["purpose"],
        name:json["name"],
        cnic:json["cnic"],
        father_name:json["father_name"],
        doa:json["doa"],
        cell_no_primary:json["cell_no_primary"],
        cell_no_secondary:json["cell_no_secondary"],
        gender:json["gender"],
        domicile_district:json["domicile_district"],
        district_id:json["district_id"],
        married:json["married"],
        eobi:json["eobi"],
        eobi_no:json["eobi_no"],
        work_from:json["work_from"],
        work_type:json["work_type"],
        perm_address:json["perm_address"],
        perm_district:json["perm_district"]
    );
  }

  Map<dynamic, dynamic> toJson(){
    Map<dynamic,dynamic> data = {};
    if(id!=null)
      data['id'] = id;
    if(purpose!=null)
      data['purpose'] = purpose;
    if(name!=null)
      data['name'] = name;
    if(cnic!=null)
      data['cnic'] = cnic;
    if(father_name!=null)
      data['father_name'] = father_name;
    if(doa!=null)
      data['doa'] = doa;
    if(cell_no_primary!=null)
      data['cell_no_primary'] = cell_no_primary;
    if(cell_no_secondary!=null)
      data['cell_no_secondary'] = cell_no_secondary;
    if(gender!=null)
      data['gender'] = gender;
    if(domicile_district!=null)
      data['domicile_district'] = domicile_district;
    if(district_id!=null)
      data['district_id'] = district_id;
    if(married!=null)
      data['married'] = married;
    if(eobi!=null)
      data['eobi'] = eobi;
    if(eobi_no!=null)
      data['eobi_no'] = eobi_no;
    if(work_from!=null)
      data['work_from'] = work_from;
    if(work_type!=null)
      data['work_type'] = work_type;
    if(perm_address!=null)
      data['perm_address'] = perm_address;
    if(perm_district!=null)
      data['perm_district'] = perm_district;
    return data;

  }

}*/