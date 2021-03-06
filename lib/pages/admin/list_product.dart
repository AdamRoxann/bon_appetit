import 'dart:convert';

import 'package:bon_appetit/model/all_product_model.dart';
import 'package:bon_appetit/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllProduct extends StatefulWidget {
  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  var loading = false;
  final list = new List<ProductModel>();
  Future<void> _allProduct() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(ProductUrl.show_product);
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
      setState(() {
        loading = false;
      });
    }
  }

  delete(id) async {
    final response = await http.post(ProductUrl.delete_product, body: {
      "id": id,
      // "password": password,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];

    if (value == 1) {
      _refresh.currentState.show();
      _showToastSuccess(message);

      // loginToast(message);
    } else {
      // print("fail");
      _showToast('Gagal menghapus product');
      // print(message);
      // loginToast(message);
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
    _allProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('All Product'),
      ),
      body: RefreshIndicator(
        key: _refresh,
        onRefresh: _allProduct,
        child: list.isEmpty
            ? Center(child: Text('Belum ada Product'))
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return
                      // Text(x.product_name);
                      Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          // leading: Icon(Icons.arrow_drop_down_circle),
                          title: Text(x.product_name),
                          subtitle: Text(
                            "Rp. " + x.price.toString(),
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Image.network(ImageUrl.product_img + x.product_img,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                          return Text('Your error widget...');
                        }),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 8.0, top: 15.0),
                          child: Text(
                            x.product_description,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            // FlatButton(
                            //   textColor: const Color(0xFF6200EE),
                            //   onPressed: () {
                            //     // Perform some action
                            //   },
                            //   child: Icon(Icons.remove),
                            // ),
                            // Text('0'),
                            // FlatButton(
                            //   textColor: const Color(0xFF6200EE),
                            //   onPressed: () {
                            //     // Perform some action
                            //   },
                            //   child: Icon(Icons.add),
                            // ),
                          ],
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            Text('Delete Product'),
                            InkWell(
                                onTap: () {
                                  delete(x.id.toString());
                                },
                                child: Icon(Icons.close)),
                          ],
                        )

                        // Image.asset('assets/card-sample-image-2.jpg'),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
