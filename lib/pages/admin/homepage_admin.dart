import 'package:bon_appetit/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageAdmin extends StatefulWidget {
  @override
  _HomePageAdminState createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  // @override
  // void initState() {
  //   super.initState();
  //   print(widget.role);
  // }

  LoginStatus _loginStatus = LoginStatus.notSignIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text('This is Admin'),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                dense: true,
                leading:
                    // Icon(Icons.search,
                    Icon(Icons.do_not_disturb_alt),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, fontFamily: "Poppins Regular"),
                ),
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  setState(() {
                    preferences.setInt('value', null);
                    preferences.setString('role', null);
                    preferences.commit();
                    _loginStatus = LoginStatus.notSignIn;
                  });
                  await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext ctx) => Login()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
