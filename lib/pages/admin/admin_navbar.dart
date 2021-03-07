import 'package:bon_appetit/pages/admin/add_product.dart';
import 'package:bon_appetit/pages/admin/all_kurir.dart';
import 'package:bon_appetit/pages/admin/list_product.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:bon_appetit/pages/admin/homepage_admin.dart';

// void main() => runApp(NavBar());

class NavBarAdmin extends StatefulWidget {
  // final String user_img;
  @override
  _NavBarAdminState createState() => _NavBarAdminState();
}

class _NavBarAdminState extends State<NavBarAdmin> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePageAdmin(),
    AllProduct(),
    AllKurir(),
    AddProduct(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //Wrap out body with a `WillPopScope` widget that handles when a user is cosing current route
      onWillPop: () async {
        Future.value(
            false); //return a `Future` with false value so this route cant be popped or closed.
      },
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: buildCustomNavigationBar(),
      ),
    );
  }

  CustomNavigationBar buildCustomNavigationBar() {
    return CustomNavigationBar(
        scaleFactor: 0.4,
        backgroundColor: Colors.white,
        selectedColor: Colors.black,
        unSelectedColor: new Color(0xFF7F8C8D),
        strokeColor: new Color(0xFFF39C12),
        currentIndex: _currentIndex,
        onTap: onTappedBar,
        items: [
          CustomNavigationBarItem(icon: Icons.home),
          CustomNavigationBarItem(icon: Icons.list_alt),
          CustomNavigationBarItem(icon: Icons.agriculture_rounded),
          CustomNavigationBarItem(icon: Icons.api_rounded),
          // CustomNavigationBarItem(icon: Icons.notifications),
          // CustomNavigationBarItem(icon: Icons.person),
        ]);
  }
}
