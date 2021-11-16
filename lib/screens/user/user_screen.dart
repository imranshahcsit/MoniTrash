import 'package:flutter/material.dart';
import 'package:moni_trash/utils/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moni_trash/main.dart';
import '../../main.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final userFullNameController = new TextEditingController();
  final userUsernameController = new TextEditingController();
  final userPasswordController = new TextEditingController();
  final userConfirmPasswordController = new TextEditingController();
  String dropdownValue = 'Operator';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MoniTrash"),
      ),
//
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
//
            Center(
              child: Text(
                "Add New User",
                style: TextStyle(color: Colors.blue),
              ),
            ),
//
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
//
                    // Enter Full Name
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name can not be blank';
                        }
                        return null;
                      },
                      controller: userFullNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Full Name",
                        labelText: "Full Name",
                      ),
                    ),
                    SizedBox(height: 40.0),
//
                    // Enter Username
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username can not be blank';
                        }
                        return null;
                      },
                      controller: userUsernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Username",
                        labelText: "Username",
                      ),
                    ),
                    SizedBox(height: 40.0),
//
                    // Enter Password
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password can not be e blank';
                        }
                        return null;
                      },
                      controller: userPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Password",
                        labelText: "Password",
                      ),
                    ),
                    SizedBox(height: 40.0),
//
                    // Confirm Password
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please Confirm password';
                        }
                        return null;
                      },
                      controller: userConfirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Confirm Password",
                        labelText: "Confirm Password",
                      ),
                    ),
                    SizedBox(height: 20.0),
//
                    // Dropdown user Role
                    Row(
                      children: [
                        Text("  Select User Role",
                            style: TextStyle(fontSize: 18)),
                        //SizedBox(width: 40.0),
                        Spacer(),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['Operator', 'Admin']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child:
                                  Text(value, style: TextStyle(fontSize: 18)),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
//
                    // Register Button
                    ElevatedButton(
                      onPressed: () {
                        //  if (_formKey.currentState!.validate()) {
                        try {
                          var variable=connection.query(
                              'insert into tblusers (fullName, userName, userPass, userRole) values (?, ?, ?,?)',
                              [
                                userFullNameController.text,
                                userUsernameController.text,
                                userPasswordController.text,
                                dropdownValue
                              ]);
                //          if(true)
                //             {
                //               print(variable);
                //             }
                          deleteUsersList();
                          myfun();
                          Fluttertoast.showToast(
                              msg: "Successful",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: "Add user failed, check internet connection",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          print('error: $e');
                        }
                        print(" Data inserted Successfully");
                        //   }
                      },
                      child: Text("Register User"),
                      style: TextButton.styleFrom(minimumSize: Size(500, 45)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          //  myfun();
                          //fun(tableSitesRowsLength);
                          Navigator.pushNamed(
                              context, MyRoutes.showAllUsersRoute);
                        });
                      },
                      child: Text("Show all Users"),
                      style: TextButton.styleFrom(minimumSize: Size(500, 45)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
