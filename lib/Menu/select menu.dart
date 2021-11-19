import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Cart%20Pages/Cart%20Files.dart';
import 'package:flameandcoal/Constant Folder/Constant File.dart';
import 'package:flameandcoal/Fav%20Food/Fav%20Food%20File.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

final database = FirebaseDatabase.instance.reference();
final FirebaseAuth _uth = FirebaseAuth.instance;

class FCShowProduct extends StatelessWidget {
  final String productname;
  final String name;
  final String menu;

  FCShowProduct({@required this.productname, this.name, this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFBD2F),
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.share_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              Share.share(
                  'https://play.google.com/store/apps/details?id=com.haythamtech.flameandcoal');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.favorite_border_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FCFavorite()));
            },
          )
        ],
      ),
      body: Products(
        productname: this.productname,
        name: this.name,
        menu: this.menu,
      ),
    );
  }
}

class Products extends StatefulWidget {
  final String productname;
  final String name;
  final String menu;

  Products({@required this.productname, this.name, this.menu});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  double height;
  double width;
  int count = 1;
int productnextpass;
  String name;
  String productname;
  String productprice;
  String productimage;
  String productdes;
  String productcal;
  String productweight;
  String deliverytime;

  List data;
  bool isLoading = false;

  void _getProductmenu(String productname, name, menu) async {
   await database
        .child(menu)
        .child(name)
        .child(productname)
        .once()
        .then((DataSnapshot snapshot) {
      var data = snapshot.value;

      setState(() {
        isLoading = true;
        productimage = data['productimg'];
        productdes = data['productdes'];
        productprice = data['productprice'];
        productcal = data['productcal'];
        productweight = data['productweight'];
        deliverytime = data['producttime'];
        var productrs = int.parse(data['productprice']);
        productnextpass=productrs;
      });
    });
  }

  void _getdealmenu(String productname, menu) async {
   await database
        .child(menu)
        .child(productname)
        .once()
        .then((DataSnapshot snapshot) {
      var data = snapshot.value;

      setState(() {
        isLoading = true;
        productimage = data['productimg'];
        productdes = data['productdes'];
        productprice = data['productprice'];
        productcal = data['productcalo'];
        productweight = data['productweight'];
        deliverytime = data['producttime'];
        var productrs = int.parse(data['productprice']);
        productnextpass=productrs;
      });
    });
  }

  Future _AdditemtoCart() {
    User user = _uth.currentUser;
    String id = user.uid;
    if (count != 0) {
      database
          .child("additemincart")
          .child(id)
          .child(widget.productname)
          .update({
        'productmenu': widget.menu,
        'productcat': widget.name,
        'productimg': productimage,
        'deliverytime': deliverytime,
        'porignalprice': productprice,
        'productname': widget.productname,
        'producttotalprice': productnextpass.toString(),
        'totalproductselect': count.toString(),
        'userid': id,
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FCCart()));
    } else {
      Fluttertoast.showToast(
          msg: "Please Select Number of Product",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: btn_Color,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }
  }


  Future pushFavorite() {
    User user = _uth.currentUser;
    String id = user.uid;

    database.child('favorite').child(id).child(widget.productname).update({
      'productname': widget.productname,
      'productimg': productimage,
      'productprice': productprice,
    });
    Fluttertoast.showToast(
        msg: "Add Item in Favorite",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: btn_Color,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductmenu(widget.productname, widget.name, widget.menu);
  _getdealmenu(widget.productname, widget.menu);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return isLoading == false
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
                Text("Loading...", style: LoadingText),
              ],
            ),
          )
        : SingleChildScrollView(
            child: Container(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: width * 0.03),
                    child: Text(
                      widget.name,
                      style: FCProductTags,
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: height * 0.04, left: width * 0.03,right: width*0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(

                          child: Text(
                            widget.productname.toString(),
                            style: FCProductName,
                          ),
                        ),
                        Container(

                          child: Text(
                            'Rs: '+ productprice + '/-',
                            style: TextStyle(fontSize: 19, fontFamily: 'Circularstd-Med'),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.07),
                    child: Image.asset('assets/images/showproductBG.png'),
                  ),
                  Container(
                    height: height * 0.6,
                    width: width * 1.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    margin: EdgeInsets.only(top: height * 0.3),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(1),
                        margin: EdgeInsets.only(top: height * 0.2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 2)),
                        child: ClipOval(
                          child: Image.network(
                            productimage,
                            height: 120,
                            width: 120,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFFFFBD2F)),
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                 margin: EdgeInsets.only(top: height*0.31,left: width*0.06,right: width*0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.1,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                          //    color: Color(0xFFFFBD2F),
                              borderRadius: BorderRadius.circular(25)),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Text('Calories',
                                style: TextStyle(fontFamily: 'PoppinRegular'),
                                ),
                              ),
                              Divider(
                                indent: 10,
                                endIndent: 10,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                child:  Text(productcal + ' kkal',
                                    style: FCProductRatio),
                              )
                            ],
                          )
                        ),
                        Container(

                            height: height * 0.1,
                            width: width * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Text('Weight',
                                    style: TextStyle(fontFamily: 'PoppinRegular'),
                                  ),
                                ),
                                Divider(
                                  indent: 15,
                                  endIndent: 13,
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                Container(
                                  child:  Text(productweight + ' gr',
                                      style: FCProductRatio),
                                )
                              ],
                            )
                        ),

                      ],
                    ),
                  ),

                  Positioned(
                    top: height * 0.46,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: width * 0.03,
                      ),
                      child: Text(
                        'Descriptions',
                        style: FCProductDescTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.52,
                    child: Container(
                      width: width * 0.9,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: width * 0.03, right: width * 0.03),
                      child: Text(
                        productdes,
                        style: FCProductDesc,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.64,
                    child: Container(
                      margin: EdgeInsets.only(left: width * 0.03),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: height * 0.01),
                                  child: Text(
                                    'TotalPrice',
                                    style: FCProductPrice,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Rs: ' + productnextpass.toString() + '/-',
                                    style: FCProductPriceRs,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: width * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if(count>1){
                                        count--;
                                        var productrs = int.parse(productprice);
                                        productnextpass -=productrs;
                                      }else{
                                        Fluttertoast.showToast(
                                            msg: "No more",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: btn_Color,
                                            textColor: Colors.black,
                                            fontSize: 16.0
                                        );
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text('-', style: FCProductIncrement),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: width * 0.02, right: width * 0.02),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFBD2F),
                                      shape: BoxShape.circle),
                                  child: Text(count.toString(),
                                      style: FCProductIncrement),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      count++;
                                    var productrs = int.parse(productprice);
                                      productnextpass += productrs;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        shape: BoxShape.circle),
                                    child: Text(
                                      '+',
                                      style: FCProductIncrement,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.77,
                    child: Container(
                      width: width * 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: height * 0.07,
                            width: width * 0.13,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  pushFavorite();
                                });
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                                size: 19,
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.07,
                            width: width * 0.6,
                            child: RaisedButton.icon(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 3,
                              label: Text(
                                'Add to Bucket',
                                style: FCProductAddBucket,
                              ),
                              icon: FaIcon(
                                FontAwesomeIcons.shoppingBasket,
                                size: 20,
                              ),
                              onPressed: () {
                                _AdditemtoCart();
                              },
                              color: Color(0xFFFFBD2F),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
