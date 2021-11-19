import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/ContinueGuest/HomePage.dart';
import 'package:flameandcoal/ContinueGuest/MainMenu.dart';
import 'package:flameandcoal/ContinueGuest/guestLogin.dart';
import 'package:flutter/material.dart';

class GuestBottomNavBar extends StatefulWidget {
  @override
  _GuestBottomNavBarState createState() => _GuestBottomNavBarState();
}

class _GuestBottomNavBarState extends State<GuestBottomNavBar> {
  int _page = 0;
  double width;
  double height;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> _widgetOptions = <Widget>[
    GuestFCHome(),
    GuestFCMenu(),
    GuestFCLogin(),
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
              Icons.fastfood_sharp,
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
