import 'dart:convert';

import 'package:bon_appetit/auth/register.dart';
import 'package:bon_appetit/pages/homepage.dart';
// import 'package:bon_appetit/pages/kurir/homepage_kurir.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String username, password;
  String roleAdmin = 'Admin';
  String roleKurir = 'Kurir';
  String roleUser = 'User';
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http.post("http://10.0.2.2:8000/api/login", body: {
      "username": username,
      "password": password,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String changeProf = data['changeProf'];
    String usernameAPI = data['username'];
    String api_keyAPI = data['api_key'];
    String roleAPI = data['role'];
    String id = data['id'];

    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, id, username, api_keyAPI, roleAPI);
        // savePref(value, id, username, role, api_keyAPI);
      });
      print(message);
      // loginToast(message);
    } else {
      print("fail");
      print(message);
      // loginToast(message);
    }
  }

  // loginToast(String toast) {
  //   return Fluttertoast.showToast(
  //       msg: toast,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIos: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white);
  // }

  savePref(int value, String id, String username, String api_key,
      String role) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("username", username);
      preferences.setString("api_key", api_key);
      preferences.setString("role", role);
      preferences.setString("id", id);
      preferences.commit();
    });
  }

  var value, role;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      role = preferences.getString("role");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    // if (role == roleAdmin)
    //   return HomePageAdmin(role);
    // else if (role == roleKurir)
    //   return HomePageKurir(role);
    // else if (role == roleUser)
    //   return HomePage(role);
    // else
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: Colors.black,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 130.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 508,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 140,
                                    top: 20,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Log In Now!',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontFamily: 'Times New Roman',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    top: 40,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        validator: (e) {
                                          if (e.isEmpty) {
                                            return "Please Insert Username";
                                          }
                                        },
                                        style: TextStyle(color: Colors.white),
                                        onSaved: (e) => username = e,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              // borderRadius:
                                              // BorderRadius.circular(25.0),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            labelText: 'Username',
                                            labelStyle:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    top: 20,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        validator: (e) {
                                          if (e.isEmpty) {
                                            return "Password Can't be Empty";
                                          }
                                        },
                                        style: TextStyle(color: Colors.white),
                                        obscureText: _secureText,
                                        onSaved: (e) => password = e,
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            enabledBorder: OutlineInputBorder(
                                              // borderRadius:
                                              // BorderRadius.circular(25.0),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                            labelText: 'Password',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            suffixIcon: IconButton(
                                              color: Colors.white,
                                              onPressed: showHide,
                                              icon: Icon(_secureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                            ),
                                            focusColor: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 60,
                                  ),
                                  width: 250,
                                  child: RaisedButton(
                                    elevation: 5,
                                    splashColor: Colors.purpleAccent,
                                    padding: EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // color: Color.fromRGBO(244, 217, 66, 1),
                                    color: Colors.white,
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      check();
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (context) => Register(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 20,
                                    ),
                                    width: 200,
                                    child: Center(
                                      child: Text(
                                        'Doesn\'t have an account?',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        );
        break;
      case LoginStatus.signIn:
//         // if (role == roleAdmin)
//         //   return HomePageAdmin(role);
//         // else if (role == roleKurir)
//         //   return HomePageKurir(role);
//         // else
        return HomePage();
        // return role == roleAdmin ? HomePageAdmin(role) : HomePage(role);
// //        return ProfilePage(signOut);
        break;
    }
  }
}
