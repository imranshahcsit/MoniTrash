import 'package:flutter/material.dart';

import '../../main.dart';

class ShowAllSitesScreen extends StatefulWidget {
  const ShowAllSitesScreen({Key? key}) : super(key: key);

  @override
  _ShowAllSitesScreenState createState() => _ShowAllSitesScreenState();
}

class _ShowAllSitesScreenState extends State<ShowAllSitesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MoniTrash"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: fun(context, tableSitesRowsLength),
        ),
      ),
    );
  }
}
