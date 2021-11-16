import 'package:flutter/material.dart';

import '../../main.dart';

class ShowAllUsersScreen extends StatefulWidget {
  const ShowAllUsersScreen({Key? key}) : super(key: key);

  @override
  _ShowAllUsersScreenState createState() => _ShowAllUsersScreenState();
}

class _ShowAllUsersScreenState extends State<ShowAllUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MoniTrash"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: funForUsers(context, tableUsersRowsLength),
        ),
      ),
    );
  }
}
