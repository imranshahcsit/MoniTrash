import 'package:flutter/material.dart';
import 'package:moni_trash/utils/routes.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MoniTrash"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
//
            const Center(
              child: Text(
                "Please login to continue",
                style: TextStyle(color: Colors.blue),
              ),
            ),
//
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Column(
                children: [
//
                // Username
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Username",
                      labelText: "Username",
                    ),
                  ),
//
                // Password
                  SizedBox(height: 40.0),
                  TextFormField(
                    // Password
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Password",
                      labelText: "Password",
                    ),
                  ),
//
                  SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.homeRoute);
                    },
                    child: Text("Login"),
                    style: TextButton.styleFrom(minimumSize: Size(500, 45)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
