import 'dart:developer';

import 'package:cmlw_labour_registration/pages/mineral_title.dart';
import 'package:cmlw_labour_registration/services/leaseServices.dart';
import "package:flutter/material.dart";

class DistrictPage extends StatefulWidget {
  @override
  _DistrictPageState createState() => _DistrictPageState();
}

class _DistrictPageState extends State<DistrictPage> {

  LeaseService service = new LeaseService();
  late Future<List<dynamic>> districts = service.getDistricts();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select District"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: districts,
        builder: (context, dataSnap){
          //log("Data Snap",name: "District",error: dataSnap.data);
          if(dataSnap.hasData){
            List<dynamic> data = dataSnap.data as List;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)=>MineralTitlePage(district: data[index].district)));
                        },
                        title:Text("${data[index].district}")
                    ),
                  );
                }
            );
          }else{
            return ListTile(
              title: Text("No District"),
            );
          }
        },
      ),
    );
  }
}
