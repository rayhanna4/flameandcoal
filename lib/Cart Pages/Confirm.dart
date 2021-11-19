import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/Drawer%20Files/Drawer%20Page.dart';
import 'package:flameandcoal/Tracker%20Folder/Tracker%20File.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FCConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: ConfirmOrder(),
    );
  }
}

class ConfirmOrder extends StatefulWidget {
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {

  double height;
  double width;

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    width: width*1.0,
                    height: height*1.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/sprinkle.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height*0.25,
                    left: width*0.4,
                    child: Container(
                      child: Icon(
                        Icons.check_circle_outline_rounded,
                        color: Color(0xFFFFBD2F),
                        size: width*0.2,
                      )
                    ),
                  ),
                  Positioned(
                    top: height*0.4,
                    left: width*0.25,
                    child: Container(
                      child: Text('Your Order is\n successfully!', style: FCCartTitle,),
                    ),
                  ),
                  Positioned(
                    top: height*0.6,
                    left: width*0.1,
                    child: Container(
                      width: width * 0.8,
                      height: height * 0.06,
                      child: RaisedButton(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => TrackerTimer()),
                                  (route) => false);
                        },
                        child: Text('Tracker Timer', style: FCMyAccountBtn1),
                        color: Color(0xFFFFBD2F),
                        textColor: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.68,
                    left: width * 0.1,
                    child: Container(
                      width: width * 0.8,
                      height: height * 0.06,
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),

                        highlightedBorderColor: Color(0xFFFFBD2F),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => DrawerFile()),
                                  (route) => false);
                        },
                        borderSide: BorderSide(color: Color(0xFFFFBD2F), width: 2),
                        child: Text(
                          'Home',
                          style: FCSignInButtonTitle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

