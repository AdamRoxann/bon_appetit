import 'dart:convert';

import 'package:bon_appetit/model/all_kurir_model.dart';
import 'package:bon_appetit/model/all_product_model.dart';
import 'package:bon_appetit/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetail extends StatefulWidget {
  final String id;
  ProductDetail(this.id);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  String user_id;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString("id");
    });
  }

  // var loading = false;
  // final list = new List<KurirModel>();
  // Future<void> _allKurir() async {
  //   list.clear();
  //   setState(() {
  //     loading = true;
  //   });
  //   final response = await http.get(KurirUrl.show_kurir);
  //   if (response.contentLength == 2) {
  //     //   await getPref();
  //     // final response =
  //     //     await http.post("https://dipena.com/flutter/api/updateProfile.php");
  //     // await http.post("https://dipena.com/flutter/api/updateProfile.php");
  //     //   "user_id": user_id,
  //     //   "location_country": location_country,
  //     //   "location_city": location_city,
  //     //   "location_user_id": user_id
  //     // });

  //     // final data = jsonDecode(response.body);
  //     // int value = data['value'];
  //     // String message = data['message'];
  //     // String changeProf = data['changeProf'];
  //   } else {
  //     final data = jsonDecode(response.body);
  //     data.forEach((api) {
  //       final ab = new KurirModel(
  //         api['id'],
  //         api['username'],
  //       );
  //       list.add(ab);
  //     });
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  // delete(id) async {
  //   final response =
  //       await http.post(AdminUrl.delete_kurir, body: {
  //     "id": id,
  //     // "password": password,
  //   });

  //   final data = jsonDecode(response.body);
  //   int value = data['value'];
  //   String message = data['message'];

  //   if (value == 1) {
  //     _refresh.currentState.show();
  //     _showToastSuccess(message);

  //     // loginToast(message);
  //   } else {
  //     // print("fail");
  //     _showToast('Gagal menghapus product');
  //     // print(message);
  //     // loginToast(message);
  //   }
  // }
  //

  var loading = false;
  final list = new List<ProductModel>();
  Future<void> _product() async {
    await getPref();
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.post(ProductUrl.product_detail, body: {
      "id": widget.id,
    });
    if (response.contentLength == 2) {
      //   await getPref();
      // final response =
      //     await http.post("https://dipena.com/flutter/api/updateProfile.php");
      // await http.post("https://dipena.com/flutter/api/updateProfile.php");
      //   "user_id": user_id,
      //   "location_country": location_country,
      //   "location_city": location_city,
      //   "location_user_id": user_id
      // });

      // final data = jsonDecode(response.body);
      // int value = data['value'];
      // String message = data['message'];
      // String changeProf = data['changeProf'];
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new ProductModel(
          api['id'],
          api['product_name'],
          api['price'],
          api['product_description'],
          api['product_img'],
          api['category_id'],
        );
        list.add(ab);
      });
      if (this.mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  save() async {
    await getPref();
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => _loading(context),
    // );
    final response = await http.post(OrderUrl.addCart, body: {
      "user_id": user_id,
      "product_id": widget.id,
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

    } else {
      // print(message);
      // Navigator.pop(context);
      _showToast('Add to cart failed');
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

  @override
  void initState() {
    super.initState();
    getPref();
    _product();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: new AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Product Detail'),
        ),
        body: RefreshIndicator(
          key: _refresh,
          onRefresh: _product,
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              final x = list[i];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Card(
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: x.product_img == null
                                  ? CircularProgressIndicator()
                                  : Image.network(
                                      // new_image_url
                                      // 'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054__340.jpg')),
                                      ImageUrl.product_img + x.product_img,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    )),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                  // decoration: BoxDecoration(
                                  //     color: Colors.black, shape: BoxShape.circle),
                                  width: 90,
                                  height: 40,
                                  color: Colors.black45,
                                  child: x.price == null
                                      ? Center(
                                          child: Text(
                                          // 'Rp. ' + new_harga,
                                          'Rp.',
                                          style: new TextStyle(
                                              color: Colors.white),
                                        ))
                                      : Center(
                                          child: Text(
                                          // 'Rp. ' + new_harga,
                                          'Rp.' + x.price.toString(),
                                          style: new TextStyle(
                                              color: Colors.white),
                                        ))),
                            ),
                          ),
                          // Container(
                          //     // width: 80,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Image(
                          //         image: NetworkImage(
                          //           ImageUrl.product_img+
                          //           x.product_img.toString(),
                          //         ),
                          //       ),
                          //     )),
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //       top: 4.0, bottom: 4.0),
                          //   child: Text(x.product_name),
                          // )
                        ],
                      ),
                    ),
                    // SizedBox(height: 15),
                    // Text(
                    //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore er dolore.",
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 13,
                    //     fontFamily: "Poppins Regular",
                    //   ),
                    // ),
                    // SizedBox(height: 25),
                    // SizedBox(
                    //   width: 650,
                    //   height: 50,
                    //   child: RaisedButton(
                    //     color: Color(0xFFF39C12),
                    //     elevation: 0,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     child: Text(
                    //       "Collabs",
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 18,
                    //         fontFamily: "Poppins Medium",
                    //       ),
                    //     ),
                    //     onPressed: () {},
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < list.length; i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: x.product_img == null
                                          ? Container()
                                          : CircleAvatar(
                                              child: ClipOval(
                                                child: Image(
                                                  width: 50,
                                                  height: 50,
                                                  image: NetworkImage(
                                                    ImageUrl.product_img +
                                                        x.product_img,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          // "Sasha Witt",
                                          x.product_name ?? "",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontFamily: "Poppins Semibold",
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3.0),
                                          child: Text(
                                            // "@sasha",
                                            'Rp. ' + x.price.toString() ?? "",
                                            style: TextStyle(
                                              color: Color(0xFF7F8C8D),
                                              fontSize: 13,
                                              fontFamily: "Poppins Regular",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   width: 80,
                                //   height: 25,
                                //   child: OutlineButton(
                                //     borderSide: BorderSide(
                                //       color: Color(0xFFF39C12),
                                //     ),
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(5),
                                //     ),
                                //     child: Text(
                                //       "Follow",
                                //       style: TextStyle(
                                //         color: Color(0xFFF39C12),
                                //         fontSize: 13,
                                //         fontFamily: "Poppins Regular",
                                //       ),
                                //     ),
                                //     onPressed: () {},
                                //   ),
                                // ),
                              ],
                            ),
                          SizedBox(height: 15),
                          Text(
                            x.product_description,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: "Poppins Regular",
                            ),
                          ),
                          SizedBox(height: 25),
                          SizedBox(
                            width: 650,
                            height: 50,
                            child: RaisedButton(
                              // color: Color(0xFFF39C12),
                              color: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Poppins Medium",
                                ),
                              ),
                              onPressed: () {
                                save();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Image.asset('assets/card-sample-image-2.jpg'),
                  ],
                ),
              );
            },
          ),
        )
        // Text('Ini All Kurir'),
        );
  }
}
