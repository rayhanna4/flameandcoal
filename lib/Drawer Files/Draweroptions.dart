import 'package:firebase_auth/firebase_auth.dart';
import 'package:flameandcoal/Bottom%20Bar/Bottom%20Nav%20Bar.dart';
import 'package:flameandcoal/Cart%20Pages/Cart%20Files.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/Deals%20Page/Deals.dart';
import 'package:flameandcoal/Events/Events%20Files.dart';
import 'package:flameandcoal/FAQ/FAQ%20File.dart';
import 'package:flameandcoal/FeedBack/Feedback.dart';
import 'package:flameandcoal/LogoutFolder/LogoutFile.dart';
import 'package:flameandcoal/Menu/MainMenu.dart';
import 'package:flameandcoal/Phone%20Auth/signin_start.dart';
import 'package:flameandcoal/Tracker%20Folder/Tracker%20File.dart';
import 'package:flutter/material.dart';
import 'package:flameandcoal/Account Folder/my_account.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Flame &  Coal", Icons.home_sharp),
    new DrawerItem("Menu", Icons.restaurant_menu_sharp),
    new DrawerItem("Events", Icons.event_available_sharp),
    new DrawerItem("Deals", Icons.fastfood_sharp),
    new DrawerItem("Cart", Icons.shopping_basket_sharp),
    new DrawerItem("Tracker", Icons.pedal_bike_sharp),
    new DrawerItem("FAQ", Icons.bookmark_border_sharp),
    new DrawerItem("My Account", Icons.account_box_sharp),
    new DrawerItem("Feedback", Icons.help_sharp),
    new DrawerItem("Sign Out", Icons.logout),
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new BottomNavBar();
      case 1:
        return new FCMenu();
      case 2:
        return new FCEvents();
      case 3:
        return new FCDeals();
      case 4:
        return new FCCart();
      case 5:
        return new TrackerTimer();
      case 6:
        return new FCFAQFile();
      case 7:
        return new FCAccount();
      case 8:
        return new FCFeedback();
      case 9:
        return new Logout();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(
          d.icon,
          color: Color(0xFFFFBD2F),
        ),
        title: new Text(
          d.title,
          style: TextStyle(
              fontFamily: 'Circularstd-Med', fontWeight: FontWeight.w700),
        ),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFBD2F),
        title: Center(
            child: new Text(
          widget.drawerItems[_selectedDrawerIndex].title,
          style: TextStyle(color: Colors.black, fontFamily: 'Circularstd-Med'),
        )),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Container(
            child: IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FCSignInStart()),
                    (route) => false);
              },
            ),
          ),
        ],
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: new Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: new Column(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: Container(
                      alignment: Alignment.center,
                      child: new Text(
                        "We Deliver the Best",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Circularstd-Med'),
                      ),
                    ),
                    accountEmail: null,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFBD2F),
                      image: DecorationImage(
                          image: AssetImage(splashimg1), fit: BoxFit.cover),
                    ),
                  ),
                  new Column(children: drawerOptions)
                ],
              ),
            ),
          ),
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
