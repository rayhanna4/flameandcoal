import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/ContinueGuest/guestLogin.dart';
import 'package:flameandcoal/Menu/select%20menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final database=FirebaseDatabase.instance.reference();
class GuestFCsignalMenu extends StatelessWidget {
  String name;
  GuestFCsignalMenu({@required this.name});

  @override
  Widget build(BuildContext context) {
    return menuFull(
      name: name,
    );
  }
}

class menuFull extends StatefulWidget {


  String name;
  menuFull({@required this.name});

  @override
  _menuFullState createState() => _menuFullState();
}

class _menuFullState extends State<menuFull> {
  double width;
  double height;
  String name;
  var menu='menu';

  List data;
  bool isLoading = false;

  void _getProductmenu(){
    database.child(menu).child(name).once().then((DataSnapshot snapshot){


      setState(() {
        isLoading = true;
        Map<dynamic, dynamic> map = snapshot.value;
        data = map.values.toList();
      });
    });

  }



  void _name (String name){
    this.name=name;
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name(widget.name);
    _getProductmenu();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFBD2F),
        elevation: 0,
        leading:  IconButton(
          icon: Icon(
              Icons.arrow_back_ios_sharp
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
        title: Center(
          child: Text(name, style: FCMenuTitle, ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: height * 0.8,
              width: width * 1.0,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage(singalmenu1),
                  fit: BoxFit.cover,
                  colorFilter:
                  ColorFilter.mode(Colors.black.withOpacity(0.5),
                      BlendMode.dstATop),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height*0.08,left: width*0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height*0.05,
                  ),
                  Container(
                    child: Text(name,
                      style: TextStyle(color: Colors.white,fontSize: width*0.08,fontFamily: 'Circularstd-Med',letterSpacing: 1),
                    ),
                  ),
                  SizedBox(
                    height: height*0.02,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.25),
              width: width * 1.0,
              height: height * 0.7,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      child: Text(
                        "Flame n Coal Menu",
                        style: FCsignalMenuheadingText,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    isLoading == false
                        ? Container(
                      child: Column(
                        children: [
                          Center(
                              child: Image.asset('assets/images/gifs/loading.gif',
                                height: height*0.45,
                                // fit: BoxFit.cover,
                              )
                          ),
                          Text("Loading...",
                              style: TextStyle(fontSize: 18, fontFamily: 'PoppinRegular',color: Colors.black)),
                        ],
                      ),
                    )
                        :ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data == null ? 0 : data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.center,
                            width: width * 1.0,
                            height: height * 0.2,
                            child: Stack(
                              children: [
                                Container(
                                  width: width * 0.9,
                                  height: height * 0.17,
                                  margin: EdgeInsets.only(
                                      top: height * 0.04, left: width * 0.02),
                                  child: Card(
                                    elevation: 12,
                                    shadowColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      // borderRadius: BorderRadius.circular(10),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100),
                                          bottomRight: Radius.circular(50),
                                        )
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: width * 0.22,
                                              height: height * 0.05,
                                              child: RaisedButton(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(18),
                                                    bottomRight:
                                                    Radius.circular(18),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GuestFCLogin()));
                                                },
                                                color: Color(0xFFFFBD2F),
                                                child: Text('Order', style: TextStyle(fontFamily: 'Circularstd-Med'),),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.05,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                          EdgeInsets.only(left: width*0.1),
                                          child: Text(
                                            data[index]['productname'].toString(),
                                            style: FCsignalMenusubheadingText,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: width*0.08),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text('('+data[index]['productrating']+')',
                                                    style: TextStyle(fontSize: 12, fontFamily: 'PoppinRegular',color: Color(0xFFFFBD2F)),
                                                  ),
                                                  Container(
                                                    child: Icon(Icons.star,
                                                      color: Color(0xFFFFBD2F),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(right: width*0.08),
                                                alignment: Alignment.topRight,
                                                child: Text('Rs '+data[index]['productprice']+'/-'.toString(),
                                                  style: TextStyle(fontSize: 15, fontFamily: 'PoppinRegular',color: Color(0xFFFFBD2F)),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                        offset:Offset(0,3),
                                      )
                                    ],
                                    shape: BoxShape.circle,
                                    color: Color(0xFFFFBD2F),
                                    // borderRadius: BorderRadius.circular(10)
                                  ),
                                  margin: EdgeInsets.only(left: width * 0.08,top: height*0.01),
                                  child:
                                  CircleAvatar(
                                    radius: height*0.06,
                                    backgroundImage: NetworkImage( data[index]['productimg'].toString(),),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: height*0.08,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

