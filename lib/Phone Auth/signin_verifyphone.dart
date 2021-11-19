import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/Phone%20Auth/signin_enterpin.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicator_button/progress_button.dart';

class FCVerifyPhone extends StatelessWidget {
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
      body: PhoneNumber(),
    );
  }
}

class PhoneNumber extends StatefulWidget {
  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _phonenumber = TextEditingController();

  void httpJob(AnimationController controller) async {
    controller.forward();
    await Future.delayed(Duration(seconds: 5), () {});
    controller.reset();
  }

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
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
                margin: EdgeInsets.only(top: height * 0.15),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: width * 0.8,
                            child: Text(
                              'Enter your phone number',
                              style: FCSignInStartTitle,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: width * 0.8,
                            child: Text(
                              'Please enter your phone number. You will receive a code to verify mobile number.',
                              textAlign: TextAlign.center,
                              style: FCSignInSubtitle,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Form(
                            key: _formkey,
                            child: Container(
                              width: width * 0.8,
                              height: height * 0.5,
                              child: TextFormField(
                                // obscureText: true,
                                controller: _phonenumber,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                style: TextStyle(fontFamily: 'PoppinRegular'),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  filled: true,
                                  labelText: 'Phone number',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'PoppinRegular'),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                        width: 1,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                  prefix: Padding(
                                    padding: EdgeInsets.all(1),
                                    child: Text(
                                      '+972',
                                      style: TextStyle(
                                          fontFamily: 'PoppinRegular'),
                                    ),
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.mobile_friendly,
                                    size: 25,
                                    color: icon_Color,
                                  ),
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "*Needed Phone Number";
                                  }
                                  return null;
                                },
                                onSaved: (String name) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.8,
                      height: height * 0.06,
                      child: ProgressButton(
                        color: btn_Color,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        strokeWidth: 2,
                        child: Text(
                          "CONTINUE",
                          style: FCSignInSend,
                        ),
                        onPressed: (AnimationController controller) async {
                          setState(() {
                            if (_phonenumber.text != '') {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FCSignInPinHere(
                                        phone: _phonenumber.text,
                                      )));
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Center(
                                      child: Text(
                                "Please Enter Phone Number",
                                style: TextStyle(
                                    fontFamily: 'PoppinRegular', fontSize: 20),
                              ))));
                            }
                            if (_formkey.currentState.validate()) {
                            } else {}
                          });
                          await httpJob(controller);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
