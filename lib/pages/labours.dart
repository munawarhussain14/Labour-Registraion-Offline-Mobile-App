import 'package:cmlw_labour_registration/pages/labour_detail.dart';
import 'package:cmlw_labour_registration/services/labourServices.dart';
import 'package:flutter/material.dart';

class LaboursPage extends StatefulWidget {
  LaboursPage();

  @override
  _LaboursPageState createState() => _LaboursPageState();
}

class _LaboursPageState extends State<LaboursPage> {
  LabourService labourService = new LabourService();
  late Future<List<dynamic>> labours = labourService.readAll();
  String value = "None";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Labours"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: labours,
        builder: (context, dataSnap) {
          print(dataSnap.data);
          if (dataSnap.hasData) {
            List<dynamic>? data = dataSnap.data as List;
            if (data.length > 0) {
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
                                      new LabourDetail(labour: data[index])));
                        },
                        title: Text("${data[index].name} s/o ${data[index].father_name}"),
                        subtitle: Text("${data[index].cnic}"),
                        trailing: IconButton(
                            onPressed: () {
                              labourService.delete(data[index].id);
                              setState(() {
                                labours = labourService.readAll();
                              });
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    );
                  });
            } else {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "No Labour",
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
                        "No Labour",
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
