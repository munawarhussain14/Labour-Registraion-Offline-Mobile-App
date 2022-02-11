import 'dart:convert';

import 'package:cmlw_labour_registration/layouts/form/text_field.dart';
import 'package:cmlw_labour_registration/models/area.dart';
import 'package:cmlw_labour_registration/models/labour.dart';
import 'package:cmlw_labour_registration/models/lease.dart';
import 'package:cmlw_labour_registration/pages/labour_detail.dart';
import 'package:cmlw_labour_registration/services/districtServices.dart';
import 'package:cmlw_labour_registration/services/labourServices.dart';
import 'package:cmlw_labour_registration/services/workTypeServices.dart';
import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';

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

  final LabourService labourService = new LabourService();
  final WorkTypeService service = new WorkTypeService();
  late Future<List<dynamic>> workType = service.readAll();
  final DistrictService districtService = new DistrictService();
  late Future<List<dynamic>> districts = districtService.readAll();

  //Labour labour = new Labour();

  String workTypeValue = 'None';
  String districtValue = 'None';
  List<S2Choice<String>> options = [];

  @override
  void initState() {
    super.initState();
  }

  List<S2Choice<String>> getOptions(dynamic data) {
    if (data == null) {
      return [];
    }
    List<S2Choice<String>> temp = data
        .map<S2Choice<String>>(
            (e) => S2Choice<String>(value: e.name, title: e.name))
        .toList();
    return temp;
  }

  List<S2Choice<String>> getDistricts(dynamic data) {
    if (data == null) {
      return [];
    }
    List<S2Choice<String>> temp = data
        .map<S2Choice<String>>(
            (e) => S2Choice<String>(value: e.name, title: e.name))
        .toList();
    return temp;
  }

  bool marriedValue = false;
  bool eobiValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Labour"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: workType,
          builder: (context, dataSnap) {
            //print(dataSnap.data);

            return Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      title: Text("${lease.parties}"),
                      subtitle: Text(
                          "${lease.code}\n(${lease.minerals})\nArea: ${area
                              .name}"),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
//                    textField("Purpose",purpose),
                        textField("Name", name, icon: Icons.person),
                        cnicField("CNIC", cnic),
                        textField("Father Name", father_name,
                            icon: Icons.person),
                        dateField("Date of Birth", (date) => {doa.text = date}),
                        cellField("Cell Phone Primary", cell_no_primary),
                        cellField("Cell Phone Secondary", cell_no_secondary,
                            required: false),
                        //textField("Married", married, icon: Icons.person),
                        Row(
                          children: [
                            Text("Married"),
                            Checkbox(
                              checkColor: Colors.white,
//    fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: marriedValue,
                              onChanged: (bool? value) {
                                marriedValue = value!;
                                setState(() {
                                  married.text = (marriedValue) ? "Yes" : "No";
                                });
                              },
                            )
                          ],
                        ),
                        //textField("EOBI", eobi, icon: Icons.person),
                        Row(
                          children: [
                            Text("EOBI"),
                            Checkbox(
                              checkColor: Colors.white,
                              value: eobiValue,
                              onChanged: (bool? value) {
                                eobiValue = value!;
                                setState(() {
                                  eobi.text = (value) ? "Yes" : "No";
                                });
                              },
                            )
                          ],
                        ),
                        textField("EOBI No", eobi_no,
                            icon: Icons.person, required: false),
                        dateField("Work Start From",
                                (date) => {work_start_from.text = date}),
                        SmartSelect<String>.single(
                            title: 'Work Type',
                            selectedValue: workTypeValue,
                            choiceItems: getOptions(dataSnap.data),
                            onChange: (state) =>
                                setState(() {
                                  print(state.value);
                                  work_type.text = state.value.toString();
                                  workTypeValue = state.value.toString();
                                })),
                        textField("Permanent Address", perm_address,
                            icon: Icons.card_travel),
                        FutureBuilder(
                            future: districts,
                            builder: (context, districtData) {
//                              print(districtData.data);
                              return SmartSelect<String>.single(
                                  title: 'District',
                                  selectedValue: districtValue,
                                  choiceItems: getDistricts(districtData.data),
                                  onChange: (state) =>
                                      setState(() {
                                        perm_district.text =
                                            state.value.toString();
                                        districtValue = state.value.toString();
                                      }));
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                Labour labour = setLabour();
                                Labour? temp = await labourService
                                    .readByCNIC("${labour.cnic}");
                                if (temp != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content:
                                        Text('Labour Already Registered')),
                                  );
                                } else {
                                  if (work_type.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.yellow,
                                          content:
                                          Text('Please select Work Type')),
                                    );
                                  }
                                  if (perm_district.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.yellow,
                                          content: Text(
                                              'Please select Permananet District')),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          duration: const Duration(seconds: 2),
                                          content: Text('Processing Data')),
                                    );
                                    temp = await labourService.create(labour);
                                    if (temp != null) {
                                      Labour data = temp;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text('Labour Registered')),
                                      );
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LabourDetail(labour: data)))
                                          .then((value) {
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterLabour(
                                                    lease: lease, area: area)));
                                        //print("======================");
                                        //_formKey.currentState?.reset();
                                        //resetForm();
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text('Error')),
                                      );
                                    }
                                  }
                                }
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
            );
          },
        ),
      ),
    );
  }

  void resetForm() {
    name.text = "";
    cnic.text = "";
    father_name.text = "";
    doa.text = "";
    cell_no_primary.text = "";
    cell_no_secondary.text = "";
    married.text = "";
    eobi.text = "";
    eobi_no.text = "";
    work_start_from.text = "";
    work_type.text = "";
    perm_address.text = "";
    perm_district.text = "";
    marriedValue = false;
    eobiValue = false;
  }

  Labour setLabour() {
    Map<String, dynamic> data = {};
    data['area_id'] = area.id;
    data['area_name'] = area.name;
    data['lease_code'] = area.lease_code;
    data['purpose'] = "labour";
    data['gender'] = "male";
    data["createTime"] = DateTime.now().toIso8601String();

    if (!name.text.isEmpty) {
      data['name'] = name.text;
    }
    if (!cnic.text.isEmpty) {
      data['cnic'] = cnic.text;
    }

    if (!father_name.text.isEmpty) {
      data['father_name'] = father_name.text;
    }
    if (!doa.text.isEmpty) {
      data['doa'] = doa.text;
    }
    if (!cell_no_primary.text.isEmpty) {
      data['cell_no_primary'] = cell_no_primary.text.trim();
    }
    if (!cell_no_secondary.text.isEmpty) {
      data['cell_no_secondary'] = cell_no_secondary.text.trim();
    }

    if (!married.text.isEmpty) {
      data['married'] = married.text.trim();
    }

    if (!eobi.text.isEmpty) {
      data['eobi'] = eobi.text.trim();
    } else {
      data['eobi'] = "No";
    }

    if (!eobi_no.text.isEmpty) {
      data['eobi_no'] = eobi_no.text.trim();
    }

    if (!work_start_from.text.isEmpty) {
      data['work_from'] = work_start_from.text.trim();
    }

    if (!work_type.text.isEmpty) {
      data['work_type'] = work_type.text.trim();
    }

    if (!perm_address.text.isEmpty) {
      data['perm_address'] = perm_address.text.trim();
    }

    if (!perm_district.text.isEmpty) {
      print(perm_district.text);
      data['perm_district_name'] = perm_district.text.trim();
      data['perm_district'] = 0;
    }
    print(data);
    return Labour.fromJson(data);
  }
}
