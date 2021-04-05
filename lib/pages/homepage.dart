import 'package:bon_appetit/auth/login.dart';
import 'package:bon_appetit/pages/admin/admin_navbar.dart';
import 'package:bon_appetit/pages/kurir/kurir_navbar.dart';
import 'package:bon_appetit/pages/user/user_navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var value, role;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      role = preferences.getString("role");
    });
  }

  Widget home() {
    // if (role == 'Admin')
    //   return Scaffold(
    //     body: ListView(
    //       children: [
    //         Text('Admin'),
    //         Padding(
    //           padding: const EdgeInsets.only(top: 0),
    //           child: Align(
    //             alignment: Alignment.bottomCenter,
    //             child: ListTile(
    //               dense: true,
    //               leading:
    //                   // Icon(Icons.search,
    //                   Icon(Icons.do_not_disturb_alt),
    //               title: Text(
    //                 'Logout',
    //                 style:
    //                     TextStyle(fontSize: 16, fontFamily: "Poppins Regular"),
    //               ),
    //               onTap: () async {
    //                 SharedPreferences preferences =
    //                     await SharedPreferences.getInstance();
    //                 setState(() {
    //                   preferences.setInt('value', null);
    //                   preferences.setString('role', null);
    //                   // preferences.clear();
    //                   preferences.commit();
    //                   _loginStatus = LoginStatus.notSignIn;
    //                 });
    //                 await Navigator.pushReplacement(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (BuildContext ctx) => Login()));
    //               },
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // else if (role == 'Kurir')
    //   return Scaffold(
    //     body: ListView(
    //       children: [
    //         Text('Kurir'),
    //         Padding(
    //           padding: const EdgeInsets.only(top: 0),
    //           child: Align(
    //             alignment: Alignment.bottomCenter,
    //             child: ListTile(
    //               dense: true,
    //               leading:
    //                   // Icon(Icons.search,
    //                   Icon(Icons.do_not_disturb_alt),
    //               title: Text(
    //                 'Logout',
    //                 style:
    //                     TextStyle(fontSize: 16, fontFamily: "Poppins Regular"),
    //               ),
    //               onTap: () async {
    //                 SharedPreferences preferences =
    //                     await SharedPreferences.getInstance();
    //                 setState(() {
    //                   preferences.setInt('value', null);
    //                   preferences.setString('role', null);
    //                   // preferences.clear();
    //                   preferences.commit();
    //                   _loginStatus = LoginStatus.notSignIn;
    //                 });
    //                 await Navigator.pushReplacement(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (BuildContext ctx) => Login()));
    //               },
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // else
    //   return Scaffold(
    //     body: ListView(
    //       children: [
    //         Text('Homepage'),
    //         Padding(
    //           padding: const EdgeInsets.only(top: 0),
    //           child: Align(
    //             alignment: Alignment.bottomCenter,
    //             child: ListTile(
    //               dense: true,
    //               leading:
    //                   // Icon(Icons.search,
    //                   Icon(Icons.do_not_disturb_alt),
    //               title: Text(
    //                 'Logout',
    //                 style:
    //                     TextStyle(fontSize: 16, fontFamily: "Poppins Regular"),
    //               ),
    //               onTap: () async {
    //                 SharedPreferences preferences =
    //                     await SharedPreferences.getInstance();
    //                 setState(() {
    //                   preferences.setInt('value', null);
    //                   preferences.setString('role', null);
    //                   // preferences.clear();
    //                   preferences.commit();
    //                   _loginStatus = LoginStatus.notSignIn;
    //                 });
    //                 await Navigator.pushReplacement(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (BuildContext ctx) => Login()));
    //               },
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    if (role == 'Admin')
      return NavBarAdmin();
    else if (role == 'Kurir')
      return NavBarKurir();
    else
      return NavBarUser();
  }

  @override
  void initState() {
    super.initState();
    getPref();
    print(role);
  }

  // LoginStatus _loginStatus = LoginStatus.notSignIn;
  @override
  Widget build(BuildContext context) {
    return home();
  }
}
