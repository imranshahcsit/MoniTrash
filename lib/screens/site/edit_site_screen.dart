import 'package:flutter/material.dart';
import 'package:moni_trash/main.dart';
import 'package:moni_trash/utils/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditSiteScreen extends StatefulWidget {
  const EditSiteScreen({Key? key, this.indexOfSite}) : super(key: key);
  final indexOfSite;

  @override
  State<EditSiteScreen> createState() => _EditSiteScreenState();
}

class _EditSiteScreenState extends State<EditSiteScreen> {
  final editSiteCodeController = new TextEditingController();
  final editSiteFullNameController = new TextEditingController();
  final editSiteLongController = new TextEditingController();
  final editSiteLatController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int idOfSiteThatNeedsToBeEdited = tableSites[widget.indexOfSite][0];
    editSiteCodeController.text = tableSites[widget.indexOfSite][1];
    editSiteFullNameController.text = tableSites[widget.indexOfSite][2];
    editSiteLongController.text = tableSites[widget.indexOfSite][3];
    editSiteLatController.text = tableSites[widget.indexOfSite][4];

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
                "Edit Site",
                style: TextStyle(color: Colors.blue),
              ),
            ),
//
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
//
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
//
                    // Enter Site Code
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Site Code can not be blank';
                        }
                        return null;
                      },
                      controller: editSiteCodeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Site Code",
                        labelText: "Side Code",
                      ),
                    ),
                    SizedBox(height: 40.0),
//
                    // Enter Site Name
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Site name can not be blank';
                        }
                        return null;
                      },
                      controller: editSiteFullNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Site Name",
                        labelText: "Site Name",
                      ),
                    ),
                    SizedBox(height: 40.0),
//
                    // Enter Longitude
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Longitude can not be blank';
                        }
                        return null;
                      },
                      controller: editSiteLongController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Longitude",
                        labelText: "Longitude",
                      ),
                    ),
                    SizedBox(height: 40.0),
//
                    // Enter Latitude
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Latitude can not be blank';
                        }
                        return null;
                      },
                      controller: editSiteLatController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Latitude",
                        labelText: "Latitude",
                      ),
                    ),
                    SizedBox(height: 40.0),
//
                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        //  if (_formKey.currentState!.validate()) {
                        try {
                          connection.query(
                              'update tblsites set siteName=?, siteFullName=?, siteLong=? , siteLat=? where siteID=?',
                              [
                                editSiteCodeController.text,
                                editSiteFullNameController.text,
                                editSiteLongController.text,
                                editSiteLatController.text,
                                idOfSiteThatNeedsToBeEdited
                              ]);

                            deleteList();

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
                    //fun(tableSitesRowsLength),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          //  myfun();
                          //fun(tableSitesRowsLength);
                          Navigator.pushNamed(
                              context, MyRoutes.showAllSitesRoute);
                        });
                      },
                      child: Text("Show all Sites"),
                      style: TextButton.styleFrom(minimumSize: Size(500, 45)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
