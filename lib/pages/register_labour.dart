import 'dart:convert';

import 'package:cmlw_labour_registration/layouts/form/text_field.dart';
import 'package:cmlw_labour_registration/models/area.dart';
import 'package:cmlw_labour_registration/models/labour.dart';
import 'package:cmlw_labour_registration/models/lease.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterLabour extends StatefulWidget {
  const RegisterLabour({Key? key, required this.lease, required this.area})
      : super(key: key);

  final Lease lease;
  final Area area;

  @override
  _RegisterLabourState createState() =>
      _RegisterLabourState(lease: lease, area: area);
}

class _RegisterLabourState extends State<RegisterLabour> {
  _RegisterLabourState({Key? key, required this.lease, required this.area});

  final Lease lease;
  final Area area;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController purpose = new TextEditingController();
  final TextEditingController name = new TextEditingController();
  final TextEditingController cnic = new TextEditingController();
  final TextEditingController father_name = new TextEditingController();
  final TextEditingController doa = new TextEditingController();
  final TextEditingController cell_no_primary = new TextEditingController();
  final TextEditingController cell_no_secondary = new TextEditingController();
  final TextEditingController district = new TextEditingController();
  final TextEditingController married = new TextEditingController();
  final TextEditingController eobi = new TextEditingController();
  final TextEditingController eobi_no = new TextEditingController();
  final TextEditingController work_start_from = new TextEditingController();
  final TextEditingController work_type = new TextEditingController();
  final TextEditingController perm_address = new TextEditingController();
  final TextEditingController perm_district = new TextEditingController();

  //Labour labour = new Labour();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Labour"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: ListTile(
                  title: Text("${lease.parties}"),
                  subtitle: Text(
                      "${lease.code}\n(${lease.minerals})\nArea: ${area.name}"),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
//                    textField("Purpose",purpose),
                    textField("Name", name, icon: Icons.person),
                    cnicField("CNIC", cnic),
                    textField("Father Name", father_name, icon: Icons.person),
                    dateField("Date of Birth", (date) => {doa.text = date}),
                    cellField("Cell Phone Primary", cell_no_primary),
                    cellField("Cell Phone Secondary", cell_no_secondary),
                    //textField("Married", married, icon: Icons.person),
                    marriedField("Married", (data) => {setState(() {})}),
                    //textField("EOBI", eobi, icon: Icons.person),
                    eobiField("EOBI", (data) => {setState(() {})}),
                    textField("EOBI No", eobi_no, icon: Icons.person),
                    dateField("Work Start From",
                        (date) => {work_start_from.text = date}),
                    textField("Work Type", work_type, icon: Icons.person),
                    textField("Permanent Address", perm_address,
                        icon: Icons.card_travel),
                    textField("Permanent District", perm_district,
                        icon: Icons.card_travel),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          print(jsonEncode(setLabour()));
                          if (_formKey.currentState!.validate()) {
                            print("Success");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Labour setLabour() {
    Map<String, dynamic> data = {};
    data['area_id'] = area.id;
    data['area_name'] = area.name;
    data['lease_code'] = area.lease_code;
    data['purpose'] = "labour";
    /*if(!purpose.text.isEmpty){
      labour.purpose = purpose.text;
    }*/
    if (!name.text.isEmpty) {
      data['name'] = name.text;
    }
    if (!cnic.text.isEmpty) {
      data['cnic'] = cnic.text;
    }
    /*
    if(!father_name.text.isEmpty){
      labour.father_name = father_name.text;
    }
    if(!doa.text.isEmpty){
      //labour.doa = doa.text;
    }
    if(!cell_no_primary.text.isEmpty){
      labour.cell_no_primary = cell_no_primary.text.trim();
    }
    if(!cell_no_secondary.text.isEmpty){
      labour.cell_no_secondary = cell_no_secondary.text.trim();
    }
    if(!district.text.isEmpty){
      //labour.district_id = district.text.trim();
    }
    if(!married.text.isEmpty){
      labour.married = married.text.trim();
    }
    if(!eobi.text.isEmpty){
      labour.eobi = eobi.text.trim();
    }
    if(!eobi_no.text.isEmpty){
      labour.eobi_no = eobi_no.text.trim();
    }
    if(!work_start_from.text.isEmpty){
      //labour.work_from = work_start_from.text;
    }
    if(!work_type.text.isEmpty){
      //labour.work_type = work_type.text;
    }
    if(!perm_address.text.isEmpty){
      labour.perm_address = perm_address.text.trim();
    }
    if(!perm_district.text.isEmpty){
      // labour.perm_district = perm_district.text;
    }*/
    return Labour.fromJson(data);
  }
}
