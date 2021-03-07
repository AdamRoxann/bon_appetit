import 'dart:convert';

import 'package:bon_appetit/model/category_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePageUser extends StatefulWidget {
  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  int new_id;
  String new_nama, new_harga, new_image_url, new_stars, nodata;
  List<Category> categories = [
    Category(
      '1',
      'Breakfast',
    ),
    Category(
      '2',
      'Lunch',
    ),
    Category(
      '3',
      'Dinner',
    ),
    Category(
      '4',
      'Drinks',
    ),
    Category(
      '5',
      'Fast Food',
    ),
  ];

  newProduct() async {
    final response = await http.get("http://10.0.2.2:8000/api/newproduct");

    final data = jsonDecode(response.body);
    int value = data['value'];
    int id_new = data['id'];
    String nama_new = data['nama'];
    String harga_new = data['harga'];
    String image_url_new = data['image_url'];
    String stars_new = data['stars'];

    if (value == 1) {
      setState(() {
        // _loginStatus = LoginStatus.signIn;
        // savePref(value, id, username, api_keyAPI, roleAPI);
        // savePref(value, id, username, role, api_keyAPI);
        new_id = id_new;
        new_nama = nama_new;
        new_harga = harga_new;
        new_image_url = image_url_new;
        new_stars = stars_new;
      });
      // print(message);
      // loginToast(message);
    } else {
      // print("fail");
      nodata = 'Tidak ada product';
      // print(message);
      // loginToast(message);
    }
  }

  @override
  void initState() {
    super.initState();
    newProduct();
    // print(new_image_url);
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
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.05,
                height: MediaQuery.of(context).size.height / 13,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final x = categories[index];
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: FlatButton(
                            // borderSide: BorderSide(
                            color: Colors.black,
                            // ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              x.text,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: "Poppins Regular",
                              ),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   new MaterialPageRoute(
                              //     builder: (context) => CategoryPage(x),
                              //   ),
                              // );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                                // new_image_url
                                'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054__340.jpg')),
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
                                child: Center(
                                    child: Text(
                                  // 'Rp. ' + new_harga,
                                  'Rp. 25000',
                                  style: new TextStyle(color: Colors.white),
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
                                      child: Text(
                                    'Our new Product!!! Burger Daging Babi Asap',
                                    // 'Our new Product!!! ' + new_nama,
                                    style: new TextStyle(color: Colors.black),
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
            )
          ],
        )
        // body: Container(),
        );
  }
}
