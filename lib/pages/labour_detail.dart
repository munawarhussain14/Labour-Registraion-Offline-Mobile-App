import 'package:cmlw_labour_registration/models/labour.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LabourDetail extends StatefulWidget {
  LabourDetail({Key? key, required this.labour});

  final Labour labour;

  @override
  _LabourDetailState createState() => _LabourDetailState(labour: labour);
}

class _LabourDetailState extends State<LabourDetail> {
  _LabourDetailState({required this.labour});

  final Labour labour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Labour Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Name"),
                subtitle: Text("${labour.name}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Father Name"),
                subtitle: Text("${labour.father_name}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text("CNIC"),
                subtitle: Text("${labour.cnic}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.date_range),
                title: const Text("Date of Birth"),
                subtitle: Text("${getDate(labour.doa)}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text("Cell No Primary"),
                subtitle: Text("${labour.cell_no_primary}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text("Cell No Secondary"),
                subtitle: Text("${labour.cell_no_primary}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.group),
                title: const Text("Married"),
                subtitle: Text("${labour.married}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.card_travel),
                title: const Text("EOBI"),
                subtitle: Text("${labour.eobi}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.card_travel),
                title: const Text("EOBI No"),
                subtitle: Text("${(labour.eobi_no!=null)?labour.eobi_no:"None"}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.date_range),
                title: const Text("Work Strat From"),
                subtitle: Text("${getDate(labour.work_from)}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.work),
                title: const Text("Work Type"),
                subtitle: Text("${labour.work_type}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.local_activity),
                title: const Text("Permanent Address"),
                subtitle: Text("${labour.perm_address}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.local_activity),
                title: const Text("Permanent District"),
                subtitle: Text("${labour.perm_district_name}"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? getDate(String? dateString) {
    if (dateString != null) {
      DateTime date = DateTime.parse(dateString);
      String formattedDate = DateFormat("dd-MM-yyyy").format(date);
      return formattedDate;
    }
    return null;
  }
}
