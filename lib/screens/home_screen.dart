import 'package:flutter/material.dart';
import 'package:moni_trash/utils/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MoniTrash"),
      ),
//
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
//
        child: Column(
          children: [
            SizedBox(height: 40.0),
//
          // Add Site Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.siteRoute);
              },
              child: Text("Sites"),
              style: TextButton.styleFrom(minimumSize: Size(500, 45)),
            ),
            SizedBox(height: 40.0),
//
          // Add User Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.userRoute);
              },
              child: Text("Users"),
              style: TextButton.styleFrom(minimumSize: Size(500, 45)),
            )
          ],
        ),
      )),
    );
  }
}
