import 'package:flutter/material.dart';
import 'package:moni_trash/main.dart';
import 'package:moni_trash/utils/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({Key? key, this.indexOfUser}) : super(key: key);
  final indexOfUser;

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final editUserFullNameController = new TextEditingController();
  final editUserUsernameController = new TextEditingController();
  final editUserPasswordController = new TextEditingController();
  final editUserConfirmPasswordController = new TextEditingController();
  String editDropdownValue = 'Operator';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int idOfUserThatNeedsToBeEdited = tableUsers[widget.indexOfUser][0];
    editUserFullNameController.text = tableUsers[widget.indexOfUser][1];
    editUserUsernameController.text = tableUsers[widget.indexOfUser][2];
    editUserPasswordController.text = tableUsers[widget.indexOfUser][3];
    editUserConfirmPasswordController.text = tableUsers[widget.indexOfUser][4];
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
                      controller: editUserFullNameController,
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
                      controller: editUserUsernameController,
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
                          return 'Password can not be blank';
                        }
                        return null;
                      },
                      controller: editUserPasswordController,
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
                      controller: editUserConfirmPasswordController,
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
                          value: editDropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          onChanged: (String? newValue) {
                            setState(() {
                              editDropdownValue = newValue!;
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
                          connection.query(
                              'update tblusers set fullName=?, userName=?, userPass=? , userRole=? where userID=?',
                              [
                                editUserFullNameController.text,
                                editUserUsernameController.text,
                                editUserPasswordController.text,
                                editDropdownValue,
                                idOfUserThatNeedsToBeEdited
                              ]);
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
                              msg: "Add site failed, check internet connection",
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
                      child: Text("Save"),
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
