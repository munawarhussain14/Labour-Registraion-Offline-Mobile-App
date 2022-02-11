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

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Select Mineral Title');

  @override
  void initState() {
    super.initState();
    customSearchBar = Text("Labours");
  }

  @override
  Widget build(BuildContext context) {
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
                      onChanged: (value) {
                        setState(() {
                          if(value!=""){
                            labours = labourService.readWhere(value);
                          }

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
                } else if (customIcon.icon == Icons.cancel) {
                  customSearchBar = Text("Labours");
                  customIcon = const Icon(Icons.search);
                  setState(() {
                    labours = labourService.readAll();
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
                        title: Text(
                            "${data[index].name} s/o ${data[index].father_name}"),
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
