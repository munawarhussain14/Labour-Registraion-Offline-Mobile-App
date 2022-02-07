import 'dart:convert';

import 'package:cmlw_labour_registration/layouts/form/text_field.dart';
import 'package:cmlw_labour_registration/models/labour.dart';
import 'package:flutter/material.dart';

class RegisterLabour extends StatefulWidget {
  const RegisterLabour({Key? key}) : super(key: key);

  @override
  _RegisterLabourState createState() => _RegisterLabourState();
}

class _RegisterLabourState extends State<RegisterLabour> {

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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                textField("Purpose",purpose),
                textField("Name",name),
                textField("CNIC",cnic),
                textField("Father Name",father_name),
                textField("Date of Birth",doa),
                textField("Cell Phone Primary",cell_no_primary),
                textField("Cell Phone Secondary",cell_no_secondary),
                textField("Married",married),
                textField("EOBI",eobi),
                textField("EOBI No",eobi_no),
                textField("Work Start From",work_start_from),
                textField("Work Type",work_type),
                textField("Permanent Address",perm_address),
                textField("Permanent District",perm_district),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      setLabour();
                      if (_formKey.currentState!.validate()) {
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
          ),
        ),
      ),
    );
  }

  void setLabour(){
    /*if(!purpose.text.isEmpty){
      labour.purpose = purpose.text;
    }
    if(!name.text.isEmpty){
      labour.name = name.text;
    }
    if(!cnic.text.isEmpty){
      labour.cnic = cnic.text;
    }
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
  }
}
