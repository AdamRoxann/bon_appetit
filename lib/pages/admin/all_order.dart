import 'dart:convert';

import 'package:bon_appetit/model/all_kurir_model.dart';
import 'package:bon_appetit/model/all_order.dart';
import 'package:bon_appetit/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllOrder extends StatefulWidget {
  @override
  _AllOrderState createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrder> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  var loading = false;
  final list = new List<OrderModel>();
  Future<void> _allOrder() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get('http://10.0.2.2:8000/api/showOrder');
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
        final ab = new OrderModel(
          api['id'],
          api['user_id'],
          api['order_list_id'],
          api['product_id'],
          api['quantity'],
          api['vendor_id'],
          api['payment_id'],
          api['status_id'],
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  delete(id) async {
    final response = await http.post(OrderUrl.delete_order, body: {
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
      _showToast('Gagal menghapus Order');
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
    _allOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: new AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('All Order'),
        ),
        body: RefreshIndicator(
          key: _refresh,
          onRefresh: _allOrder,
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              final x = list[i];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(x.product_id.toString()),
                      // subtitle: Text(
                      //   "Rp. " + x.harga,
                      //   style:
                      //       TextStyle(color: Colors.black.withOpacity(0.6)),
                      // ),
                    ),
                    // Image.network(x.image_url),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(bottom: 8.0, top: 15.0),
                    //   child: Text(
                    //     x.deskripsi,
                    //     style:
                    //         TextStyle(color: Colors.black.withOpacity(0.6)),
                    //   ),
                    // ),
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
                        Text('Hapus Order'),
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
        )
        // Text('Ini All Kurir'),
        );
  }
}
