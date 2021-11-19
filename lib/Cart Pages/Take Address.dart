import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TakeAddress extends StatelessWidget {
  String card;

  TakeAddress({@required this.card});

  @override
  Widget build(BuildContext context) {
    return AdrressFull(
      card: card,
    );
  }
}

class AdrressFull extends StatefulWidget {
  String card;

  AdrressFull({@required this.card});

  @override
  _AdrressFullState createState() => _AdrressFullState();
}

class _AdrressFullState extends State<AdrressFull> {
  double height;
  double width;
  String card;

  void _card(String card) {
    this.card = card;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _card(widget.card);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFBD2F),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
            child: Text(
          "YOUR ORDER",
          style: AppBar_text,
        )),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/welcome/home');
            },
            child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.times,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/welcome/home');
                }),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: width * 1.0,
                      height: height * 0.24,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(
                        top: height * 0.6,
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFFFFBD2F).withOpacity(0.4),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2))
                          ],
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Sub Total",
                                  style: FCAddressUserName,
                                ),
                              ),
                              Container(
                                child: TextButton(
                                  child: Text(
                                    "RS 1000/-",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Total",
                                  style: FCAddressUserName,
                                ),
                              ),
                              Container(
                                child: TextButton(
                                  child: Text(
                                    "RS 1000/-",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 1.0,
                      height: height * 0.22,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(
                        top: height * 0.41,
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFFFFBD2F).withOpacity(0.4),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Total Item",
                                  style: FCAddressUserName,
                                ),
                              ),
                              Container(
                                child: TextButton(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Item 5",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  wordSpacing: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 1.0,
                      height: height * 0.22,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(
                        top: height * 0.22,
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFFFFBD2F).withOpacity(0.4),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2))
                          ],
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Payment Method.dart",
                                  style: FCAddressUserName,
                                ),
                              ),
                              Container(
                                child: TextButton(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              card,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  wordSpacing: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 1.0,
                      height: height * 0.25,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFFFFBD2F).withOpacity(0.4),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Checkout',
                              style: FCCheckoutname,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Address",
                                  style: FCAddressUserName,
                                ),
                              ),
                              Container(
                                child: TextButton(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "324-M72-Lake City Lahore",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  wordSpacing: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back_sharp),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Container(
                        width: width * 0.35,
                        height: height * 0.06,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {},
                          child: Text(
                            'OrderNow',
                            style: FCCartCheckOut,
                          ),
                          color: Color(0xFFFFBD2F),
                          textColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
