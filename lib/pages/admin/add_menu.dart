import 'dart:convert';

import 'package:bon_appetit/pages/admin/add_kurir.dart';
import 'package:bon_appetit/pages/admin/add_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddMenu extends StatefulWidget {
  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _key = new GlobalKey<FormState>();
  String nama, harga, deskripsi, image_url, stars;

  // check() {
  //   final form = _key.currentState;
  //   if (form.validate()) {
  //     form.save();
  //     save();
  //     // Navigator.push(
  //     //   context,
  //     //   new MaterialPageRoute(
  //     //     builder: (context) => RegisterTwo(user_fullname, user_email),
  //     //   ),
  //     // );
  //   }
  // }

  // save() async {
  //   // showDialog(
  //   //   barrierDismissible: false,
  //   //   context: context,
  //   //   builder: (BuildContext context) => _loading(context),
  //   // );
  //   final response =
  //       await http.post('http://10.0.2.2:8000/api/addproduct', body: {
  //     // "username": username,
  //     // "password": password,
  //     // "role": 'Kurir',
  //     'nama': nama,
  //     'harga': harga,
  //     'deskripsi': deskripsi,
  //     'image_url': image_url,
  //     'stars': stars,
  //   });

  //   final data = jsonDecode(response.body);
  //   int value = data['value'];
  //   String message = data['message'];
  //   // String messageEnglish = data['messageEnglish'];
  //   if (value == 1) {
  //     // setState(() {
  //     // Navigator.pop(context);
  //     // });
  //     // showDialog(
  //     //   context: context,
  //     //   builder: (BuildContext context) => _popUpGallery(context),
  //     // );
  //     // Navigator.push(
  //     //   context,
  //     //   new MaterialPageRoute(
  //     //     builder: (context) => Login(),
  //     //   ),
  //     // );
  //     // login();
  //     // print(message);
  //     _showToastSuccess(message);
  //     // registerToast(message);

  //   } else if (value == 2) {
  //     // print(message);
  //     // Navigator.pop(context);
  //     _showToast('Gagal Menambah Product');
  //     // _showToast(messageEnglish);
  //     // registerToast(message);
  //   } else {
  //     // print(message);
  //     // Navigator.pop(context);
  //     _showToast('Gagal Menambah Product');
  //     // registerToast(message);
  //   }
  // }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text(
              'Add Menu',
              style: new TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
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
                    'Add Product',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => AddProduct(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
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
                    'Add Kurir',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => AddKurir(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
