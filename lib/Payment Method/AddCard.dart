import 'package:flameandcoal/Cart%20Pages/proceedcheckout.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddCard extends StatelessWidget {
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
  TextEditingController _cardnumber = TextEditingController();

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                width: width * 1.0,
                height: height * 0.55,
                decoration: BoxDecoration(
                  color: Color(0xFFFFBD2F),
                ),
              ),
              Positioned(
                top: height * 0.08,
                left: width * 0.05,
                width: width * 0.9,
                child: Container(
                  alignment: Alignment.center,
                  child: Text('Add Card', style: FCSignInStartTitle),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54.withOpacity(0.2),
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(0, 2))
                    ]),
                margin: EdgeInsets.only(
                    top: height * 0.25,
                    left: width * 0.02,
                    right: width * 0.02),
                width: width * 0.96,
                height: height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        cardImage,
                        height: height * 0.15,
                      ),
                    ),
                    Container(
                      width: width * 0.85,
                      height: 50,
                      child: TextField(
                        // obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          labelText: 'Card Holder',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                width: 1,
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          suffixIcon: const Icon(
                            Icons.person,
                            color: Color(0xFFFFBD2F),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width * 0.85,
                      height: 50,
                      child: TextField(
                        // obscureText: true,
                        controller: _cardnumber,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          labelText: '0000 0000 0000 0000',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                width: 1,
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          suffixIcon: const Icon(
                            Icons.credit_card_sharp,
                            color: Color(0xFFFFBD2F),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width * 0.85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.4,
                            height: 50,
                            child: TextField(
                              // obscureText: true,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                fillColor: Colors.grey.withOpacity(0.1),
                                filled: true,
                                labelText: 'CVC',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                      width: 1,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                suffixIcon: const Icon(
                                  Icons.credit_card_sharp,
                                  color: Color(0xFFFFBD2F),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.4,
                            height: 50,
                            child: TextField(
                              // obscureText: true,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                fillColor: Colors.grey.withOpacity(0.1),
                                filled: true,
                                labelText: 'Exp-',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                      width: 1,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                suffixIcon: const Icon(
                                  Icons.credit_card_sharp,
                                  color: Color(0xFFFFBD2F),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.5,
                      height: height * 0.09,
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FCProceedCheckout(
                                    method: _cardnumber.text.toString(),
                                  )));
                        },
                        borderSide:
                            BorderSide(color: Color(0xFFFFBD2F), width: 2),
                        child: Text(
                          'Add Card',
                          style: FCSignInButtonTitle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
