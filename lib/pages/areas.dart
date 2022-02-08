import 'package:cmlw_labour_registration/models/lease.dart';
import 'package:flutter/material.dart';

class AreasPage extends StatefulWidget {
  AreasPage({required this.lease});

  final Lease lease;

  @override
  _AreasPageState createState() => _AreasPageState(lease: lease);
}

class _AreasPageState extends State<AreasPage> {
  _AreasPageState({required this.lease});

  final Lease lease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Areas"),
      ),
      body: Container(
        child: Text("${lease.parties}\n${lease.code}\n${lease.minerals}"),
      ),
    );
  }
}
