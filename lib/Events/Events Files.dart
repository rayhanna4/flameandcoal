import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flutter/material.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:url_launcher/url_launcher.dart';

class FCEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FcEventsFull();
  }
}

class FcEventsFull extends StatefulWidget {
  @override
  _FcEventsFullState createState() => _FcEventsFullState();
}

class _FcEventsFullState extends State<FcEventsFull> {
  List<String> eventImg = <String>[
    'assets/images/events/birthday_party.jpg',
    'assets/images/events/engagement_party.jpg',
    'assets/images/events/outdoor_party.jpg',
    'assets/images/events/private_party.jpg',
    'assets/images/events/valentine_party.jpg',
    'assets/images/events/vip_experience.jpg',
  ];

  List<String> eventName = <String>[
    'Birthday Party',
    'Engagement Party',
    'Outdoor Party',
    'Private Party',
    'Valentine Party',
    'VIP Experience',
  ];

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              height: height * 0.8,
              width: width * 1.0,
              margin: EdgeInsets.only(top: height * 0.06),
              alignment: Alignment.center,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventImg.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _showDialog();
                      },
                      child: Container(
                        height: height * 1.0,
                        width: width * 0.85,
                        margin: EdgeInsets.only(
                            right: width * 0.03, left: width * 0.03),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.65,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  eventImg[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(eventName[index],
                                  style: TextStyle(
                                    fontSize: width * 0.05,
                                    fontFamily: 'Circularstd-Med',
                                    color: Colors.black,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    slideDialog.showSlideDialog(
        context: context,
        child: SingleChildScrollView(
          child: Container(
              height: height * 0.6,
              width: width * 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.5,
                    height: height * 0.09,
                    child: RaisedButton(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      onPressed: () {
                        _sendingMails();
                      },
                      child: Text(
                        'Contact Us',
                        style: TextStyle(fontSize: 15, fontFamily: 'PoppinRegular', fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      color: Color(0xFFFFBD2F),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Container(
                    width: width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _sendingMails();
                                },
                                child: Container(
                                  width: width * 0.2,
                                  height: height * 0.2,
                                  child: Icon(
                                    Icons.mail_outline_sharp,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFBD2F),
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Container(
                                child: Text("Mail", style: FCEventBtn),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  launch("tel:12345678");
                                },
                                child: Container(
                                  width: width * 0.2,
                                  height: height * 0.2,
                                  child: Icon(
                                    Icons.phone_android_sharp,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFBD2F),
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Container(
                                child: Text("Phone", style: FCEventBtn),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        barrierColor: Colors.white.withOpacity(0.7),
        pillColor: Color(0xFFFFBD2F),
        backgroundColor: Colors.white);
  }
}

_sendingMails() async {
  const url = 'mailto:flameandcoal@gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
