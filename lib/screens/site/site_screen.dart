import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moni_trash/utils/routes.dart';
import 'package:moni_trash/main.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../main.dart';

class SiteScreen extends StatefulWidget {
  const SiteScreen({Key? key}) : super(key: key);

  @override
  State<SiteScreen> createState() => _SiteScreenState();
}

class _SiteScreenState extends State<SiteScreen> {
  final siteCodeController = new TextEditingController();
  final siteFullNameController = new TextEditingController();
  final siteLongController = new TextEditingController();
  final siteLatController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // geolocator starts
  var currentLocationAddress;
  var currentPosition;
  getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        //      getCurrentLocationAddress();
      });
    }).catchError((e) {
      print(e);
    });
  }

  // geolocator ends

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
                "Add a new site",
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
                      controller: siteCodeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Site Code",
                        labelText: "Site Code",
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
                      controller: siteFullNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Site Name",
                        labelText: "Site Name",
                      ),
                    ),
                    SizedBox(height: 40.0),
//
                    // Enter Longitude
//                     TextFormField(
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Longitude can not be blank';
//                         }
//                         return null;
//                       },
//                       controller: siteLongController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: "Enter Longitude",
//                         labelText: "Longitude",
//                       ),
//                     ),
//                     SizedBox(height: 40.0),
// //
//                     // Enter Latitude
//                     TextFormField(
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Latitude can not be blank';
//                         }
//                         return null;
//                       },
//                       controller: siteLatController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: "Enter Latitude",
//                         labelText: "Latitude",
//                       ),
//                     ),
//                     SizedBox(height: 40.0),
                    if (currentPosition != null)
                      Text(
                        "LATITUDE:   ${currentPosition.latitude}",
                        style: TextStyle(fontSize: 23),
                      ),
                    if (currentPosition != null)
                      Text(
                        "LONGITUDE: ${currentPosition.longitude}",
                        style: TextStyle(fontSize: 23),
                      ),
//
                    // get longitude and latitude
                    ElevatedButton(
                        onPressed: () {
                          getCurrentLocation();
                        },
                        child: Text("get location")),
//
                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        //  if (_formKey.currentState!.validate()) {
                        try {
                          connection.query(
                              'insert into tblsites (siteName, siteFullName, siteLong, siteLat) values (?, ?, ?,?)',
                              [
                                siteCodeController.text,
                                siteFullNameController.text,
                                currentPosition.longitude,
                                currentPosition.latitude
                                //siteLongController.text,
                                //siteLatController.text
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
                      child: Text("Add site"),
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
