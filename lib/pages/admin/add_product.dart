// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'package:async/async.dart';
// import 'dart:io';
import 'dart:convert';
import 'dart:io';

import 'package:bon_appetit/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class Cat {
  const Cat(this.category_name);

  final String category_name;
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _key = new GlobalKey<FormState>();
  String product_name, price, product_description;
  File _imageFile;

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
  //     'product_name': product_name,
  //     'price': price,
  //     'product_description': product_description,
  //     'image_url': image_url,
  //     'category_id': _mySelection
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
  save() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => _loading(context),
    );
    // setState(() {
    //   loading = true;
    // });
    try {
      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      var length = await _imageFile.length();
      var uri = Uri.parse(ProductUrl.add_product);
      final request = http.MultipartRequest("POST", uri);
      request.fields['product_name'] = product_name;
      request.fields['price'] = price;
      // request.fields['post_title'] = post_title;
      // request.fields['post_location'] = post_location;
      request.fields['product_description'] = product_description;
      request.fields['category_id'] = _mySelection;

      request.files.add(http.MultipartFile("product_img", stream, length,
          filename: path.basename(_imageFile.path)));
      var response = await request.send();
      if (response.statusCode > 2) {
        print("Image uploaded");
        _showToastSuccess('Berhasil Menambah Product');
        Navigator.pop(context);
        // setState(() {
        //   Navigator.push(context,
        //       new MaterialPageRoute(builder: (context) => LoginPage()));
        //   // loading = false;
        //   // widget.response();
        //   // Navigator.pop(context);
        //   // Navigator.popUntil(context, => HomePage());
        //   // Navigator.of(context).popUntil((route) => route.isFirst);
        // });
      } else {
        print("Product failed to be upload");
        _showToast('Gagal Menambah Product');
      }
    } catch (e) {
      debugPrint("Error $e");
    }

    // await getPref();
    // final response = await http
    //     .post("http://dipena.com/flutter/api/post/addPost.php", body: {
    //   "post_user_id": user_id,
    //   "user_id": user_id,
    //   // "post_cat_id" : post_cat_id,
    //   "post_title": post_title,
    //   "post_location": post_location,
    //   "post_offer": post_offer,
    //   "post_description": post_description,
    // });
    // final data = jsonDecode(response.body);
    // int value = data['value'];
    // String pesan = data['message'];
    // if (value == 1) {
    //   print(pesan);
    //   setState(() {
    //     Navigator.pop(context);
    //   });
    // } else {
    //   print(pesan);
    // }
  }

  _pilihGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
  }

  _pilihCamera() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
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

  final String url = CategoryUrl.show_cat;

  String _mySelection;

  List data = List();

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  String hintText;
  serviceHint() {
    if (_mySelection == "1") {
      return "Food";
    } else if (_mySelection == "2") {
      return "Drink";
    }
  }

  @override
  void initState() {
    super.initState();
    getSWData();
  }

  Widget _popUpImage(BuildContext context) {
    return new Transform.scale(
      scale: 1,
      child: Opacity(
        opacity: 1,
        child: CupertinoAlertDialog(
            content: Text("Choose Method"),
            actions: <Widget>[
              Container(
                color: Colors.white,
                child: CupertinoDialogAction(
                  child: Text(
                    'Camera',
                    style: new TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    _pilihCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                color: Colors.white,
                child: CupertinoDialogAction(
                  child: Text(
                    'Gallery',
                    style: new TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    _pilihGallery();
                    // delete();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Add Product',
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
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 100,
                  onSaved: (e) => product_name = e,
                  // controller: txtBio,
                  style: TextStyle(fontSize: 18, fontFamily: "Poppins Regular"),
                  decoration: InputDecoration(
                    labelText: 'Product Name',
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
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 100,
                  onSaved: (e) => product_description = e,
                  // controller: txtBio,
                  style: TextStyle(fontSize: 18, fontFamily: "Poppins Regular"),
                  decoration: InputDecoration(
                    labelText: 'Product Description',
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
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  maxLength: 100,
                  onSaved: (e) => price = e,
                  // controller: txtBio,
                  style: TextStyle(fontSize: 18, fontFamily: "Poppins Regular"),
                  decoration: InputDecoration(
                    labelText: 'Price',
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
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Please select a category.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "Poppins Medium",
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 180,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonHideUnderline(
                          // child: DropdownButton<Cat>(
                          //   hint: new Text("Category"),
                          //   value: selectedCat,
                          //   onChanged: (Cat newValue) {
                          //     setState(() {
                          //       selectedCat = newValue;
                          //     });
                          //   },
                          //   items: users.map(
                          //     (Cat cat) {
                          //       return new DropdownMenuItem<Cat>(
                          //         value: cat,
                          //         child: new Text(
                          //           cat.name,
                          //           style: new TextStyle(
                          //             color: Colors.black,
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   ).toList(),
                          // ),
                          child: DropdownButton(
                            hint: new Text("Category"),
                            value: _mySelection,
                            onChanged: (newVal) {
                              setState(() {
                                _mySelection = newVal;
                              });
                            },
                            items: data.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['category_name']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     right: 15,
              //     left: 15,
              //     // top: 15,
              //   ),
              //   child: TextFormField(
              //     keyboardType: TextInputType.multiline,
              //     maxLines: null,
              //     maxLength: 100,
              //     onSaved: (e) => product_img = e,
              //     // controller: txtBio,
              //     style: TextStyle(fontSize: 18, fontFamily: "Poppins Regular"),
              //     decoration: InputDecoration(
              //       labelText: 'Image Url',
              //       labelStyle: TextStyle(
              //           color: Colors.black, fontFamily: "Poppins Regular"
              //           // fontWeight: FontWeight.bold,
              //           ),
              //       // suffixText: '0/100',

              //       focusedBorder: UnderlineInputBorder(
              //           borderSide: BorderSide(color: Colors.black)),
              //     ),
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
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
                        showDialog(
                          // barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) =>
                              _popUpImage(context),
                        );
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
                        "Choose Product Image",
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
              // Padding(
              //   padding: const EdgeInsets.only(
              //     right: 15,
              //     left: 15,
              //     // top: 15,
              //   ),
              //   child: TextFormField(
              //     keyboardType: TextInputType.number,
              //     maxLines: null,
              //     maxLength: 5,
              //     onSaved: (e) => stars = e,
              //     // controller: txtBio,
              //     style: TextStyle(fontSize: 18, fontFamily: "Poppins Regular"),
              //     decoration: InputDecoration(
              //       labelText: 'Stars',
              //       labelStyle: TextStyle(
              //           color: Colors.black, fontFamily: "Poppins Regular"
              //           // fontWeight: FontWeight.bold,
              //           ),
              //       // suffixText: '0/100',

              //       focusedBorder: UnderlineInputBorder(
              //           borderSide: BorderSide(color: Colors.black)),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, left: 15.0, right: 15.0, bottom: 15.0),
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
                        "Save Product",
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
