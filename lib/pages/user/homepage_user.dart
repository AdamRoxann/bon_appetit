import 'dart:convert';

import 'package:bon_appetit/model/category_model.dart';
import 'package:bon_appetit/url.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePageUser extends StatefulWidget {
  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  int new_id;
  String product_name, product_description, product_img, category_id, price;
  List<Category> categories = [
    Category('1', 'Breakfast', 'assets/images/breakfast.png'),
    Category('2', 'Lunch', 'assets/images/fried-rice.png'),
    Category('3', 'Dinner', 'assets/images/serving-dish.png'),
    Category('4', 'Drinks', 'assets/images/orange-juice.png'),
    Category('5', 'Fast Food', 'assets/images/hamburger.png'),
  ];

  newestProduct() async {
    final response = await http.get(ProductUrl.newest_product);

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String product_nameAPI = data['product_name'];
    String product_descriptionAPI = data['product_description'];
    String product_imgAPI = data['product_img'];
    String category_idAPI = data['category_id'];
    String priceAPI = data['price'];
    int idAPI = data['id'];

    if (value == 1) {
      print(message);
      if (this.mounted) {
        setState(() {
          product_name = product_nameAPI;
          product_description = product_descriptionAPI;
          product_img = product_imgAPI;
          category_id = category_idAPI;
          price = priceAPI;
        });
      }

      // loginToast(message);
    } else {
      print("fail");
      print(message);
      // loginToast(message);
    }
  }

  // newProduct() async {
  //   final response = await http.get("http://10.0.2.2:8000/api/newproduct");

  //   final data = jsonDecode(response.body);
  //   int value = data['value'];
  //   int id_new = data['id'];
  //   String nama_new = data['nama'];
  //   String harga_new = data['harga'];
  //   String image_url_new = data['image_url'];
  //   String stars_new = data['stars'];

  //   if (value == 1) {
  //     setState(() {
  //       // _loginStatus = LoginStatus.signIn;
  //       // savePref(value, id, username, api_keyAPI, roleAPI);
  //       // savePref(value, id, username, role, api_keyAPI);
  //       new_id = id_new;
  //       new_nama = nama_new;
  //       new_harga = harga_new;
  //       new_image_url = image_url_new;
  //       new_stars = stars_new;
  //     });
  //     // print(message);
  //     // loginToast(message);
  //   } else {
  //     // print("fail");
  //     nodata = 'Tidak ada product';
  //     // print(message);
  //     // loginToast(message);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    newestProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            automaticallyImplyLeading: false),
        // child: Text('User')
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: product_img == null
                                ? CircularProgressIndicator()
                                : Image.network(
                                    // new_image_url
                                    // 'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054__340.jpg')),
                                    ImageUrl.product_img +
                                        product_img,
                                    width: double.infinity, fit: BoxFit.fill,
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
                                child: price == null
                                    ? Center(
                                        child: Text(
                                        // 'Rp. ' + new_harga,
                                        'Rp.',
                                        style:
                                            new TextStyle(color: Colors.white),
                                      ))
                                    : Center(
                                        child: Text(
                                        // 'Rp. ' + new_harga,
                                        'Rp.' + price,
                                        style:
                                            new TextStyle(color: Colors.white),
                                      ))),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                  // decoration: BoxDecoration(
                                  //     color: Colors.black, shape: BoxShape.circle),
                                  // width: 90,
                                  height: 40,
                                  color: Colors.white,
                                  child: Center(
                                      child: product_name == null
                                          ? Text(
                                              'Our new Product!!! Burger Daging Babi Asap',
                                              // 'Our new Product!!! ' + new_nama,
                                              style: new TextStyle(
                                                  color: Colors.black),
                                            )
                                          : Text(
                                              'Our new Product!!! ' +
                                                  product_name,
                                              // 'Our new Product!!! ' + new_nama,
                                              style: new TextStyle(
                                                  color: Colors.black),
                                            ))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //     child: Column(
                  //   children: <Widget>[
                  //     CarouselSlider(
                  //       options: CarouselOptions(
                  //         autoPlay: true,
                  //         aspectRatio: 2.0,
                  //         enlargeCenterPage: true,
                  //       ),
                  //       items: imageSliders,
                  //     ),
                  //   ],
                  // )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.05,
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final x = categories[index];
                    return Column(
                      children: <Widget>[
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 6),
                        //   child: FlatButton(
                        //     // borderSide: BorderSide(
                        //     color: Colors.black,
                        //     // ),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(5),
                        //     ),
                        //     child: Text(
                        //       x.text,
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 13,
                        //         fontFamily: "Poppins Regular",
                        //       ),
                        //     ),
                        //     onPressed: () {
                        //       // Navigator.push(
                        //       //   context,
                        //       //   new MaterialPageRoute(
                        //       //     builder: (context) => CategoryPage(x),
                        //       //   ),
                        //       // );
                        //     },
                        //   ),
                        // ),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                  width: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image(
                                      image: AssetImage(
                                        x.image.toString(),
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, bottom: 4.0),
                                child: Text(x.text),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        )
        // body: Container(),
        );
  }
}
