import 'dart:convert';

import 'package:bon_appetit/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddKurir extends StatefulWidget {
  @override
  _AddKurirState createState() => _AddKurirState();
}

class _AddKurirState extends State<AddKurir> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _key = new GlobalKey<FormState>();
  String username, password, vendor;

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
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => _loading(context),
    // );
    final response = await http.post(AdminUrl.add_kurir,
        body: {
          "username": username,
          "password": password,
          "role": 'Kurir',
          "vendor": vendor
        });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    // String messageEnglish = data['messageEnglish'];
    if (value == 1) {
      // setState(() {
      // Navigator.pop(context);
      // });
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) => _popUpGallery(context),
      // );
      // Navigator.push(
      //   context,
      //   new MaterialPageRoute(
      //     builder: (context) => Login(),
      //   ),
      // );
      // login();
      // print(message);
      _showToastSuccess(message);
      // registerToast(message);

    } else if (value == 2) {
      // print(message);
      // Navigator.pop(context);
      _showToast('Gagal Menambah Kurir');
      // _showToast(messageEnglish);
      // registerToast(message);
    } else {
      // print(message);
      // Navigator.pop(context);
      _showToast('Gagal Menambah Kurir');
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

  _showToastSuccess(String toast) {
    final snackbar = SnackBar(
      content: new Text(toast),
      backgroundColor: Colors.green,
    );
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Add Kurir',
            style: new TextStyle(color: Colors.white),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: const Icon(Icons.add_alert),
          //     tooltip: 'Show Snackbar',
          //     onPressed: () {
          //       // ScaffoldMessenger.of(context).showSnackBar(
          //       //     const SnackBar(content: Text('This is a snackbar')));
          //     },
          //   ),
          //   IconButton(
          //     icon: const Icon(Icons.navigate_next),
          //     tooltip: 'Go to the next page',
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(
          //         builder: (BuildContext context) {
          //           return Scaffold(
          //             appBar: AppBar(
          //               title: const Text('Next page'),
          //             ),
          //             body: const Center(
          //               child: Text(
          //                 'This is the next page',
          //                 style: TextStyle(fontSize: 24),
          //               ),
          //             ),
          //           );
          //         },
          //       ));
          //     },
          //   ),
          // ],
        ),
        body: Form(
          key: _key,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                  // top: 15,
                ),
                child: TextFormField(
                  onSaved: (e) => username = e,
                  // controller: txtBio,
                  style: TextStyle(fontSize: 18, fontFamily: "Poppins Regular"),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                        color: Colors.black, fontFamily: "Poppins Regular"
                        // fontWeight: FontWeight.bold,
                        ),
                    // suffixText: '0/100',

                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                  // top: 15,
                ),
                child: TextFormField(
                  obscureText: _secureText,
                  onSaved: (e) => password = e,
                  // controller: txtBio,
                  style: TextStyle(fontSize: 18, fontFamily: "Poppins Regular"),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Colors.black, fontFamily: "Poppins Regular"
                        // fontWeight: FontWeight.bold,
                        ),
                    suffixIcon: IconButton(
                      onPressed: showHide,
                      icon: Icon(_secureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    // suffixText: '0/100',

                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                  // top: 15,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 100,
                  onSaved: (e) => vendor = e,
                  // controller: txtBio,
                  style: TextStyle(fontSize: 18, fontFamily: "Poppins Regular"),
                  decoration: InputDecoration(
                    labelText: 'Vendor',
                    labelStyle: TextStyle(
                        color: Colors.black, fontFamily: "Poppins Regular"
                        // fontWeight: FontWeight.bold,
                        ),
                    // suffixText: '0/100',

                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, left: 15.0, right: 15.0, bottom: 15.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.black,
                      splashColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      onPressed: () async {
                        check();
                        // setState(() {
                        //   chat_user_id = post_user_id;
                        // });
                        // var navigationResult = await Navigator.push(
                        //   context,
                        //   new MaterialPageRoute(
                        //     builder: (context) => ChatUserProfile(chat_user_id),
                        //   ),
                        // );
                        // if (navigationResult == true) {
                        //   MaterialPageRoute(
                        //     builder: (context) => Chat(),
                        //   );
                        // }
                      },
                      child: Text(
                        "Save Kurir",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: "Poppins Medium",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
