import 'package:firebase_auth/firebase_auth.dart';
import 'package:flameandcoal/Phone%20Auth/signin_start.dart';
import 'package:flutter/material.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {


  Future<void> _logout() async {
   await FirebaseAuth.instance.signOut();
   Navigator.pushAndRemoveUntil(
       context,
       MaterialPageRoute(builder: (context) => FCSignInStart()),
           (route) => false);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _logout();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }

}
