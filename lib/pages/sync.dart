import 'package:cmlw_labour_registration/database/db.dart';
import 'package:cmlw_labour_registration/models/district.dart';
import 'package:cmlw_labour_registration/models/lease.dart';
import 'package:cmlw_labour_registration/models/work_type.dart';
import 'package:cmlw_labour_registration/services/districtServices.dart';
import 'package:cmlw_labour_registration/services/leaseServices.dart';
import 'package:cmlw_labour_registration/services/workTypeServices.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class Sync extends StatefulWidget {
  const Sync({Key? key}) : super(key: key);

  @override
  _SyncState createState() => _SyncState();
}

class _SyncState extends State<Sync> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sync Data with DB"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: (){
                  syncDistrict();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('District Sync Complete')),
                  );
                },
                child: Text("Sync District", style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: (){
                  deleteAllDistrict();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All District Delete Complete')),
                  );
                },
                child: Text("Delete All Districts", style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: Colors.green,
                onPressed: (){
                  syncMineralTitle();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mineral Title Sync Complete')),
                  );
                },
                child: Text("Sync Mineral Title", style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: Colors.green,
                onPressed: (){
                  deleteAllMineralTitle();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mineral Title Delete Complete')),
                  );
                },
                child: Text("Delete All Mineral Title", style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: Colors.green,
                onPressed: (){
                  syncWorkType();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Work Type Sync Complete')),
                  );
                },
                child: Text("Sync Work Type", style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: Colors.green,
                onPressed: (){
                  deleteAllWorkType();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Work Type Delete Complete')),
                  );
                },
                child: Text("Delete All Work Type", style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: Colors.green,
                onPressed: (){
                  deleteDatabase();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Database Delete')),
                  );
                },
                child: Text("Delete Database", style: TextStyle(color: Colors.white),),
              ),
            )

          ],
        ),
      ),
    );
  }

  void deleteDatabase() async{
    DB service = new DB();
    service.removeDatabase();
  }

  Future<String> loadDistrictAsset() async {
    return await rootBundle.loadString('assets/csv/districts.csv');
  }

  void syncDistrict() async
  {
    List<List<dynamic>> rows = const CsvToListConverter().convert(await loadDistrictAsset());
    //String csv = const ListToCsvConverter().convert(rows);
    DistrictService service = new DistrictService();
    rows.asMap().forEach((index,element) async {
      if(index>0){
        await service.create(District.fromJson({"id":element[0],"name":element[1],"province":element[1]}));
      }
    });
    //List<dynamic> list = await service.readAll();
    //print(list);
  }

  void deleteAllDistrict() async
  {
    DistrictService service = new DistrictService();
    service.deleteAll();
  }

  Future<String> loadMineralTitleAsset() async {
    return await rootBundle.loadString('assets/csv/lease.csv');
  }

  void syncMineralTitle() async
  {
    List<List<dynamic>> rows = const CsvToListConverter().convert(await loadMineralTitleAsset()).toList();
    print(rows.length);
    LeaseService service = new LeaseService();
    rows.asMap().forEach((index,element) async {
      if(index>0){
        /*
        print(index);
        print(element.runtimeType);
        print(element.length);
        print(element[0]);*/
        Lease temp = await service.create(Lease.fromJson({
          "code":element[0],
          "parties":element[1],
          "rsp_office":element[2],
          "type_group":element[3],
          "type":element[4],
          "mineral_group":element[7],
          "minerals":element[6],
          "district":element[8],
          "grant_date":element[9],
          "expiry_date":element[10],
//          "area":element[11],
//          "unit":element[12]
        }));
      }
    });
    List<dynamic> list = await service.readAll();
  }

  void deleteAllMineralTitle() async
  {
    LeaseService service = new LeaseService();
    service.deleteAll();
  }

  Future<String> loadWorkTypeAsset() async {
    return await rootBundle.loadString('assets/csv/work_types.csv');
  }

  void syncWorkType() async
  {
    List<List<dynamic>> rows = const CsvToListConverter().convert(await loadWorkTypeAsset()).toList();
    WorkTypeService service = new WorkTypeService();
    //print(await service.getTables());

    rows.asMap().forEach((index,element) async {
      if(index>0){
        WorkType temp = await service.create(WorkType.fromJson({
          "id":element[0],
          "name":element[1]
        }));
      }
    });
    //List<dynamic> list = await service.readAll();
    //print(list);
  }

  void deleteAllWorkType() async
  {
    WorkTypeService service = new WorkTypeService();
    service.deleteAll();
  }


}
