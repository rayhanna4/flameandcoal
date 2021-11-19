import 'package:analog_clock/analog_clock.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/Drawer%20Files/Drawer%20Page.dart';
import 'package:flutter/material.dart';


final database = FirebaseDatabase.instance.reference();
final FirebaseAuth _uth = FirebaseAuth.instance;
class TrackerTimer extends StatefulWidget {
  @override
  _TrackerTimerState createState() => _TrackerTimerState();
}

class _TrackerTimerState extends State<TrackerTimer> {

  bool isActive=false;

String time;


  Future<void> _Tracker() async {
    User user = _uth.currentUser;
    String id = user.uid;
   await database.child('tracker').child(id).once().then((DataSnapshot snapshot) {
      var data = snapshot.value;

      setState(() {
        time = data['time'].toString();
     isActive=data['status'];

      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Tracker();
  }

  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
          backgroundColor: Colors.white,
          body:  isActive == false
              ? Container(
            child: Column(
              children: [
                Center(
                  child: Container(
                      margin: EdgeInsets.only(top: height * 0.3),
                      child: Image.asset(
                        'assets/images/gifs/loading.gif',
                        height: height * 0.2,
                      )),
                ),
                Text("No Tracker Start", style: LoadingText),
                SizedBox(
                  height: height*0.03,
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
          )
              :SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Center(
                        child: Container(
                          width: width*0.5,
                          height: height*0.5,
                          child: AnalogClock(
                            decoration: BoxDecoration(
                                border: Border.all(width: 3.0, color: Colors.black),
                                color: Colors.black,
                                shape: BoxShape.circle),
                            width: 200.0,
                            isLive: true,
                            hourHandColor: Colors.white,
                            minuteHandColor: Colors.white,
                            secondHandColor: Color(0xFFFFBD2F),
                            showSecondHand: true,
                            numberColor: Colors.white,
                            showNumbers: true,
                            textScaleFactor: 1.5,
                            showTicks: true,
                            showDigitalClock: true,
                            digitalClockColor: Colors.white,
                            datetime: DateTime(2020, 8, 4, 9, 11, 0),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: height*0.0545,
                      ),
                      Center(
                        child: Container(
                          width: width*0.9,
                          child: Text('Total Time '+time+ 'min Required to Delivery Your Order',
                          textAlign: TextAlign.center,
                          style: FCSummaryOrderPrice,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Container(
                          child: Text('Thank You',
                          style: FCSummaryOrderPrice,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: width*0.2,right: width*0.2, bottom: height*0.01),
                        width: width*0.5,
                        height: height*0.07,
                        child: RaisedButton(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          onPressed: (){
                            Navigator.pushNamed(context, '/welcome/home');
                          },
                          child: Text('Home',style: FCSummaryConfirm,),
                          color: Color(0xFFFFBD2F),

                        ),
                      )
                    ],
                  ),
                ),
              ),
        );
  }
}
