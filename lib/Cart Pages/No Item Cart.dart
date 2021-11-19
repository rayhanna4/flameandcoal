import 'package:flameandcoal/Drawer%20Files/Drawer%20Page.dart';
import 'package:flutter/material.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';

class FCNoItemCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FavoritePage(),
    );
  }
}

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: height * 0.3,
            ),
            child: Image.asset(
              'assets/images/gifs/cart.gif',
              height: height * 0.2,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: height * 0.05),
            child: Text(
              'Nothing to show',
              style: FCFavoriteTitle,
            ),
          ),
          Container(
            width: width * 0.5,
            height: height * 0.09,
            alignment: Alignment.center,
            child: OutlineButton(
              highlightedBorderColor: Color(0xFFFFBD2F),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DrawerFile()));
              },
              borderSide: BorderSide(color: Color(0xFFFFBD2F), width: 2),
              child: Text(
                'BACK',
                style: FCSignInButtonTitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
