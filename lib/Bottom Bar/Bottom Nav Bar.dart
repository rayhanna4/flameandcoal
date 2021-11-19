import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flameandcoal/Account%20Folder/my_account.dart';
import 'package:flameandcoal/Cart%20Pages/Cart%20Files.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/Fav%20Food/Fav%20Food%20File.dart';
import 'package:flameandcoal/Home%20Page/HomePage.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  double width;
  double height;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> _widgetOptions = <Widget>[
    FCHome(),
    FCCart(),
    FCFavorite(),
    FCAccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_page),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          items: <Widget>[
            Icon(
              Icons.home_sharp,
              size: 25,
              color: bottom_bar_col,
            ),
            Icon(
              Icons.shopping_basket_sharp,
              size: 25,
              color: bottom_bar_col,
            ),
            Icon(
              Icons.favorite_border_rounded,
              size: 25,
              color: bottom_bar_col,
            ),
            Icon(
              Icons.person_rounded,
              size: 25,
              color: bottom_bar_col,
            ),
          ],
          color: Colors.white,
          buttonBackgroundColor: Color(0xFFFFBD2F),
          backgroundColor: Colors.transparent,
          animationCurve: Curves.decelerate,
          animationDuration: Duration(milliseconds: 600),
          onTap: _onItemTapped,
          letIndexChange: (index) => true,
        ));
  }
}
