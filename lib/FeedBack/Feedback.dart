import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class FCFeedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: Feedback(),
    );
  }
}

class Feedback extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {

  double height;
  double width;

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width*1.0,
              height: height*0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/img.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height*0.05),
              child: Text('Thanks for\n choosing us today', textAlign: TextAlign.center,style: TextStyle( fontSize:30,fontFamily: 'Circularstd-Med', color: Color(0xFFFFBD2F), ),),
            ),
            Container(
              margin: EdgeInsets.only(top: height*0.05),
              child: Text('Rate us stars to help make\n our app even more awsome. Thank!', textAlign: TextAlign.center, style:  TextStyle(fontSize:15,fontFamily: 'Circularstd-Med', color: Colors.black, ),),
            ),
            Container(
              margin: EdgeInsets.only(top: height*0.05),
              width: width * 0.8,
              height: height * 0.06,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                onPressed: (){
                    show();
                },
                elevation: 3,
                child: Text('Rate Us', style: TextStyle(fontSize: 15, fontFamily: 'PoppinRegular', color: Colors.black, fontWeight: FontWeight.bold)),
                color: Color(0xFFFFBD2F),
                textColor: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
  void show() {
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: const Icon(
              Icons.fastfood,
              size: 100,
              color: Color(0xFFFFBD2F),
            ), // set your own image/icon widget
            title: "Flutter Rating Dialog",
            description: "Tap a star to give your rating.",
            submitButton: "SUBMIT",
            alternativeButton: "Contact us instead?", // optional
            positiveComment: "We are so happy to hear ????", // optional
            negativeComment: "We're sad to hear ????", // optional
            accentColor: Color(0xFFFFBD2F),// optional
            onSubmitPressed: (int rating) {
              print("onSubmitPressed: rating = $rating");
              // TODO: open the app's page on Google Play / Apple App Store
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
              // TODO: maybe you want the user to contact you instead of rating a bad review
            },
          );
        });
  }
}

