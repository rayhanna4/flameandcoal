import 'dart:async';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/ContinueGuest/Bottom%20Nav%20Bar.dart';
import 'package:flameandcoal/Drawer%20Files/Drawer%20Page.dart';
import 'package:flameandcoal/Phone%20Auth/signin_start.dart';
import 'package:flutter/material.dart';




class slashPageMain extends StatefulWidget {
  @override
  _slashPageMainState createState() => _slashPageMainState();
}

class _slashPageMainState extends State<slashPageMain> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:{
        '/':(context)=>SlashFull(),
        '/welcome':(context)=>FCSignInStart(),
        '/welcome/home':(context)=>DrawerFile(),
        '/welcome/home/product':(context)=>GuestBottomNavBar(),
      },
    );
  }
}
class SlashFull extends StatefulWidget {
  @override
  _SlashFullState createState() => _SlashFullState();
}

class _SlashFullState extends State<SlashFull> {


  void startTimer (){
    Timer(Duration(seconds: 3),(){
      Navigator.pushNamed(context, '/welcome');
    } );

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    backgroundColor: Color(0xFFFFBD2F),
      body: Container(
        child:
        Center(
          child: Image.asset(splashimg,width: MediaQuery.of(context).size.width*0.8,),
        ),
      ),
    );
  }
}