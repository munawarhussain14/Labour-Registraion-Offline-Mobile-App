import 'package:cmlw_labour_registration/models/area.dart';
import 'package:cmlw_labour_registration/models/lease.dart';
import 'package:cmlw_labour_registration/pages/add_areas.dart';
import 'package:cmlw_labour_registration/pages/register_labour.dart';
import 'package:cmlw_labour_registration/services/areaServices.dart';
import 'package:flutter/material.dart';
import 'package:cmlw_labour_registration/layouts/form/select.dart';

class AreasPage extends StatefulWidget {
  AreasPage({required this.lease});

  final Lease lease;

  @override
  _AreasPageState createState() => _AreasPageState(lease: lease);
}

class _AreasPageState extends State<AreasPage> {
  _AreasPageState({required this.lease});

  final Lease lease;

  AreaService areasService = new AreaService();
  late Future<List<dynamic>> areas = areasService.readWhere("lease_code = '${lease.code}'");
  String value = "None";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Areas"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    new AddAreasPage(lease: lease)))
                .then((value) {
              setState(() {
                areas = areasService.readWhere("lease_code = '${lease.code}'");
              });
            });
          }, icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: areas,
        builder: (context, dataSnap) {
          if (dataSnap.hasData) {
            List<dynamic>? data = dataSnap.data as List;
            if(data.length>0){
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterLabour(lease: lease,area: data[index])));
                        },
                        title: Text("${data[index].name}"),
                        subtitle: Text("${data[index].lease_code}"),
                        trailing: IconButton(
                            onPressed: () {
                              areasService.delete(data[index].id);
                              setState(() {
                                areas = areasService.readAll();
                              });
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    );
                  });
            }else{
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "No Area",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          } else {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "No Area",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
