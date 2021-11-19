import 'package:flameandcoal/Phone%20Auth/signin_verifyphone.dart';
import 'package:flutter/material.dart';

class GuestFCLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFBD2F),
        elevation: 0,
        title: Center(
            child: Text(
          'Account Login',
          style: TextStyle(color: Colors.black, fontFamily: 'Circularstd-Med'),
        )),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Color(0xFFFFBD2F),
          ),
        ),
      ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/gifs/fav.gif',
              height: height * 0.2,
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            width: width * 0.5,
            height: height * 0.09,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FCVerifyPhone()));
              },
              child: Text(
                'Login  First',
                style: TextStyle(fontSize: 15, fontFamily: 'PoppinRegular', fontWeight: FontWeight.bold, color: Colors.black),
              ),
              color: Color(0xFFFFBD2F),
            ),
          ),
        ],
      ),
    );
  }
}
