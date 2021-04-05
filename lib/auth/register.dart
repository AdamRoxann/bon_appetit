import 'dart:convert';

import 'package:bon_appetit/auth/login.dart';
import 'package:bon_appetit/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // LoginStatus _loginStatus = LoginStatus.notSignIn;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _key = new GlobalKey<FormState>();
  String username, password;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
      // Navigator.push(
      //   context,
      //   new MaterialPageRoute(
      //     builder: (context) => RegisterTwo(user_fullname, user_email),
      //   ),
      // );
    }
  }

  save() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => _loading(context),
    );
    final response =
        await http.post(LoginUrl.register, body: {
      "username": username,
      "password": password,
      "role": 'Admin',
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    // String messageEnglish = data['messageEnglish'];
    if (value == 1) {
      // setState(() {
      Navigator.pop(context);
      // });
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) => _popUpGallery(context),
      // );
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
      // login();
      print(message);
      // _showToast(message);
      // registerToast(message);

    } else if (value == 2) {
      print(message);
      Navigator.pop(context);
      _showToast(message);
      // _showToast(messageEnglish);
      // registerToast(message);
    } else {
      print(message);
      Navigator.pop(context);
      _showToast(message);
      // registerToast(message);
    }
  }

  _showToast(String toast) {
    final snackbar = SnackBar(
      content: new Text(toast),
      backgroundColor: Colors.red,
    );
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }

  Widget _loading(BuildContext context) {
    return new Transform.scale(
      scale: 1,
      child: Opacity(
        opacity: 1,
        child: CupertinoAlertDialog(
          title: Text("Please Wait..."),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
                // height: 50,
                // width: 50,
                child: Center(child: CircularProgressIndicator())),
          ),
        ),
      ),
    );
  }

  // _showToast(String toast) {
  //   final snackbar = SnackBar(
  //     content: new Text(toast),
  //     backgroundColor: Colors.red,
  //   );
  //   _scaffoldkey.currentState.showSnackBar(snackbar);
  // }

  bool _secureText = true;
  bool _secureTextConfirm = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  showHideConfirm() {
    setState(() {
      _secureTextConfirm = !_secureTextConfirm;
    });
  }

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
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
                                    'Register!',
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
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return 'Username cannot be empty';
                                      return null;
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
                                    controller: _pass,
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return 'Password cannot be empty';
                                      return null;
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
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 30,
                                right: 30,
                                top: 20,
                              ),
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    onSaved: (e) => password = e,
                                    controller: _confirmPass,
                                    validator: (val) {
                                      if (val.isEmpty) return 'Empty';
                                      if (val != _pass.text)
                                        return 'Password Not Match';
                                      return null;
                                    },
                                    obscureText: _secureTextConfirm,
                                    style: TextStyle(color: Colors.white),
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
                                        labelText: 'Confirmation Password',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        suffixIcon: IconButton(
                                          onPressed: showHideConfirm,
                                          icon: Icon(_secureTextConfirm
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
                                  'Register',
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
                                    builder: (context) => Login(),
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
                                    'Already have an account?',
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
  }
}
