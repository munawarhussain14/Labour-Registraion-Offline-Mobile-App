import 'package:cmlw_labour_registration/layouts/form/text_field.dart';
import 'package:cmlw_labour_registration/models/area.dart';
import 'package:cmlw_labour_registration/models/lease.dart';
import 'package:cmlw_labour_registration/services/areaServices.dart';
import 'package:flutter/material.dart';


class AddAreasPage extends StatefulWidget {
  AddAreasPage({required this.lease});

  final Lease lease;

  @override
  _AddAreasPageState createState() => _AddAreasPageState(lease: lease);
}

class _AddAreasPageState extends State<AddAreasPage> {
  _AddAreasPageState({required this.lease});

  final Lease lease;

  final _formKey = GlobalKey<FormState>();

  final AreaService services = new AreaService();

  final TextEditingController areaName = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Areas"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                textField("Mine Area Name", areaName),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: ()async {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        Area area = Area.fromJson({"name":areaName.text,"lease_code":lease.code});
                        area = await services.create(area);
                        if(area!=null){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mine Area Added')),
                          );
                          Navigator.pop(context);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mine Area not Added')),
                          );
                        }

                      }
                    },
                    child: const Text('Add'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}
