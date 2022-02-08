import 'dart:developer';

import 'package:cmlw_labour_registration/pages/areas.dart';
import 'package:cmlw_labour_registration/services/leaseServices.dart';
import "package:flutter/material.dart";

class MineralTitlePage extends StatefulWidget {

  MineralTitlePage({required this.district});

  final String district;

  @override
  _MineralTitlePageState createState() => _MineralTitlePageState(district: district);
}

class _MineralTitlePageState extends State<MineralTitlePage> {

  _MineralTitlePageState({required this.district});
  final String district;
  late int total_lease;

  LeaseService service = new LeaseService();
  late Future<List<dynamic>> districts = service.getByDistrict("",district);

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Select Mineral Title');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    customSearchBar = Text("${district} District");
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
                      onChanged: (value){
                        setState(() {
                          districts = service.getByDistrict(value,district);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Type to search...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }else if (customIcon.icon == Icons.cancel){
                  customSearchBar = Text("${district} District");
                  customIcon = const Icon(Icons.search);
                  setState(() {
                    districts = service.getByDistrict("",district);
                  });
                }
              });
            },
            icon: customIcon,
          )
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: districts,
        builder: (context, dataSnap){
          log("Data Snap",name: "District",error: dataSnap.data);
          if(dataSnap.hasData){
            List<dynamic> data = dataSnap.data as List;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                        onTap: (){
                          print(data[index].id);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)=>AreasPage(lease: data[index])));
                        },
                        title: (data[index].parties!='')?Text("${data[index].parties}"):Text("Not mentioned", style: TextStyle(color: Colors.red),),
                        subtitle: Text("${data[index].code}\n(${data[index].minerals})")
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
