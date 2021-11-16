import 'package:flutter/material.dart';
import 'package:moni_trash/screens/home_screen.dart';
import 'package:moni_trash/screens/login_screen.dart';
import 'package:moni_trash/screens/site/show_all_sites_screen.dart';
import 'package:moni_trash/screens/site/site_screen.dart';
import 'package:moni_trash/screens/user/edit_user_screen.dart';
import 'package:moni_trash/screens/user/show_all_users_screen.dart';
import 'package:moni_trash/screens/user/user_screen.dart';
import 'package:moni_trash/screens/site/edit_site_screen.dart';
import 'package:moni_trash/utils/routes.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool isDatabaseLoaded = false;
int tableSitesRowsLength = 0;
int tableUsersRowsLength = 0;
var connection;

void main() {
  myfun();
  runApp(MyApp());
}

List tableSites = [
  ['siteID', 'siteName', 'siteFullName', 'siteLong', 'siteLat']
];
List tableUsers = [
  ['userID', 'full Name', 'userName', 'userPass', 'user Role']
];

void deleteList() {
  tableSites.removeRange(1, tableSites.indexOf(tableSites.last) + 1);
}

void deleteUsersList() {
  tableUsers.removeRange(1, tableUsers.indexOf(tableUsers.last) + 1);
}

Widget meraCard(BuildContext context, int tableSitesRowsLength, int i) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: Card(
      child: Row(
        children: [
          // Text("1"),
          // Spacer(), // adds longest space as possible between two widgets
          Text(tableSites[i][2]),
          Spacer(),
          // Text("kb Site"),
          // Spacer(),
          Text(tableSites[i][3]),
          Spacer(),
          Text(tableSites[i][4]),
          Spacer(),
          // ElevatedButton(
          //     onPressed: () {
          //       // var index = tableSites[i][0];
          //       // connection.query('delete from tblsites where siteID=$index');
          //       //Navigator.pushNamed(context, MyRoutes.editSiteRoute);
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => EditSiteScreen(indexOfSite: i)));
          //     },
          //     child: Text("Edit")),
          i < 1
              ? Text("                  ")
              : ElevatedButton(
                  onPressed: () {
                    // var index = tableSites[i][0];
                    // connection.query('delete from tblsites where siteID=$index');
                    //Navigator.pushNamed(context, MyRoutes.editSiteRoute);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditSiteScreen(indexOfSite: i)));
                  },
                  child: Text("Edit")),
        ],
      ),
    ),
  );
}

Widget fun(BuildContext context, int tableSitesRowsLength) {
  List<Widget> list = [];
  for (int i = 0; i <= tableSitesRowsLength; i++) {
    list.add(meraCard(context, tableSitesRowsLength, i));
  }
  // list.add(meraCard());
  // list.add(meraCard());
  // list.add(meraCard());
  return Column(children: list);
}

Widget userCard(BuildContext context, int tableUsersRowsLength, int i) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: Card(
      child: Row(
        children: [
          // Text("1"),
          // Spacer(), // adds longest space as possible between two widgets
          Text(tableUsers[i][1]),
          Spacer(),
          // Text("kb Site"),
          // Spacer(),
//        Text(tableUsers[i][3]),
          //      Spacer(),
          Text(tableUsers[i][4]),
          Spacer(),
//           ElevatedButton(
//               onPressed: () {
//                 // var index = tableSites[i][0];
//                 // connection.query('delete from tblsites where siteID=$index');
//                 //Navigator.pushNamed(context, MyRoutes.editSiteRoute);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
// //                      builder: (context) => EditSiteScreen(indexOfSite: i)));
//                         builder: (context) => EditUserScreen(indexOfUser: i)));
//
//               },
//               child: Text("Edit")),
          i < 1
              ? Text("                 ")
              : ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
//                      builder: (context) => EditSiteScreen(indexOfSite: i)));
                            builder: (context) =>
                                EditUserScreen(indexOfUser: i)));
                  },
                  child: Text("Edit")),
        ],
      ),
    ),
  );
}

Widget funForUsers(BuildContext context, int tableUsersRowsLength) {
  List<Widget> list = [];
  for (int i = 0; i <= tableUsersRowsLength; i++) {
    list.add(userCard(context, tableUsersRowsLength, i));
  }
  // list.add(meraCard());
  // list.add(meraCard());
  // list.add(meraCard());
  return Column(children: list);
}

var settings = new ConnectionSettings(
    host: 'us-cdbr-east-04.cleardb.com',
    user: 'b64a34ba524287',
    password: '80dbf8f4',
    db: 'heroku_26a9e473ebcfb7c');
void myfun() async {
  // if Database is not connected with our app due to internet issue, catch will show a toast message
  try {
    connection = await MySqlConnection.connect(settings);
    Fluttertoast.showToast(
        msg: "Database connected successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  } catch (e) {
    Fluttertoast.showToast(
        msg: "Database did not connect, please check your internet connection",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  var results = await connection.query('select * from tblsites');
  var resultsUsers = await connection.query('select * from tblusers');

  for (var row in results) {
//    print(row[0]);
    //   if (!tableSites.contains([row[0], row[1], row[2], row[3], row[4]])) {
    tableSites.add([row[0], row[1], row[2], row[3], row[4]]);

    //  print(tableSites);
    // }
  }
  for (var row in resultsUsers) {
//    print(row[0]);
    //   if (!tableSites.contains([row[0], row[1], row[2], row[3], row[4]])) {
    tableUsers.add([row[0], row[1], row[2], row[3], row[4]]);

    //  print(tableSites);
    // }
  }
  print(tableUsers);
  tableSitesRowsLength = results.length;
  tableUsersRowsLength = resultsUsers.length;
  isDatabaseLoaded = true;
//  var result = await conn.query('insert into tblsites (siteName, siteFullName, siteLong, siteLat) values (?, ?, ?,?)', ['kechibaig', 'purana Pul', 25,344]);
//  print("New inserted row id: ${result.insertId}");

  // await conn.query(
  //     'update tblsites set siteLong=? where siteName=?',
  //     [263, 'Arifstreet']);

  // await conn.query('delete from tblsites where siteID=45');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      routes: {
        MyRoutes.loginRoute: (context) => LoginScreen(),
        MyRoutes.homeRoute: (context) => HomeScreen(),
        MyRoutes.siteRoute: (context) => SiteScreen(),
        MyRoutes.userRoute: (context) => UserScreen(),
        MyRoutes.showAllSitesRoute: (context) => ShowAllSitesScreen(),
        MyRoutes.editSiteRoute: (context) => EditSiteScreen(),
        MyRoutes.showAllUsersRoute: (context) => ShowAllUsersScreen(),
      },
    );
  }
}
