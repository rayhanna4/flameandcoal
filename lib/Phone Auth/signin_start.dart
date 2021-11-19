import 'package:firebase_auth/firebase_auth.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/Drawer%20Files/Drawer%20Page.dart';
import 'package:flameandcoal/Phone%20Auth/signin_verifyphone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _uth = FirebaseAuth.instance;

class FCSignInStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StartSignIN(),
    );
  }
}

class StartSignIN extends StatefulWidget {
  @override
  _StartSignINState createState() => _StartSignINState();
}

class _StartSignINState extends State<StartSignIN> {
  double height;
  double width;

  Future<void> _checking() async {
    User user = await _uth.currentUser;
    if (user != null) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DrawerFile()));
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checking();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
        child: Column(
      children: [
        Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              width: width * 1.0,
              height: height * 1.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bkg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.2),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    width: width * 0.6,
                    height: height * 0.25,
                    child: Image.asset(
                      welcomeimg,
                      width: MediaQuery.of(context).size.width * 1.0,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.8,
                    height: height * 0.06,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FCVerifyPhone()));
                      },
                      child: Text(
                        'Sign In / Sign Up',
                        style: FCSignInButtonTitle,
                      ),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    width: width * 0.8,
                    height: height * 0.06,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      highlightedBorderColor: Color(0xFFFFBD2F),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/welcome/home/product');
                      },
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      child: Text(
                        'Continue as Guest',
                        style: FCGuestButtonTitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
