import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/Drawer%20Files/Drawer%20Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:progress_indicator_button/progress_button.dart';

final FirebaseAuth _uth = FirebaseAuth.instance;
final database = FirebaseDatabase.instance.reference();

class FCSignInPinHere extends StatelessWidget {
  final String phone;

  FCSignInPinHere({@required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: app_bar_Color,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
        ),
      ),
      body: PinHere(
        phone: phone,
      ),
    );
  }
}

class PinHere extends StatefulWidget {
  final String phone;

  PinHere({@required this.phone});

  @override
  _PinHereState createState() => _PinHereState();
}

class _PinHereState extends State<PinHere> {
  double width;
  double height;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Color(0xFFFFBD2F),
    ),
  );

  void httpJob(AnimationController controller) async {
    controller.forward();
    await Future.delayed(Duration(seconds: 50), () {});
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
        key: _scaffoldkey,
        child: SingleChildScrollView(
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
                    height: height * 0.82,
                    margin: EdgeInsets.only(top: height * 0.15),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.8,
                                child: Text(
                                  'We need to verify your phone number',
                                  style: FCSignInPinTitle,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Container(
                                width: width * 0.8,
                                child: Text(
                                  'We have sent you an SMS with a code to number  ' +
                                      '+972' +
                                      widget.phone,
                                  style: FCSignInPinOtp,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: width * 0.12, right: width * 0.12),
                                child: PinPut(
                                  fieldsCount: 6,
                                  textStyle: FCSignInPinOtpTxt,
                                  eachFieldWidth: 20.0,
                                  eachFieldHeight: 20.0,
                                  focusNode: _pinPutFocusNode,
                                  controller: _pinPutController,
                                  submittedFieldDecoration: pinPutDecoration,
                                  selectedFieldDecoration: pinPutDecoration,
                                  followingFieldDecoration: pinPutDecoration,
                                  pinAnimationType: PinAnimationType.fade,
                                  onSubmit: (pin) async {
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithCredential(
                                              PhoneAuthProvider.credential(
                                                  verificationId:
                                                      _verificationCode,
                                                  smsCode: pin))
                                          .then((value) async {
                                        if (value.user != null) {
                                          _updateUserAddress();
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DrawerFile()),
                                              (route) => false);
                                        }
                                      });
                                    } catch (e) {
                                      FocusScope.of(context).unfocus();
                                      _scaffoldkey.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text('invalid OTP')));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: width * 0.8,
                            height: height * 0.06,
                            child: ProgressButton(
                              color: btn_Color,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              strokeWidth: 2,
                              child: Text(
                                "VERIFY NUMBER",
                                style: FCSignInSend,
                              ),
                              onPressed:
                                  (AnimationController controller) async {
                                setState(() {});
                                await httpJob(controller);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+972${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DrawerFile()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  Future _updateUserAddress() {
    String usernumber = '+972' + widget.phone;
    User user = _uth.currentUser;
    String id = user.uid;

    database.child("userphonenumber").child(id).update({
      'userphonenumber': usernumber,
      'userid': id,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
