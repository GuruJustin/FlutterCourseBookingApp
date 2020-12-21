import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:Juhuischool/screens/buydetail.dart';
import 'package:Juhuischool/screens/prizedetail.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:simple_html_css/simple_html_css.dart';
import 'package:Juhuischool/screens/videoshow.dart';
import 'package:local_auth/local_auth.dart';

int video_num = 0;
int fullscreen_v = 0;
int fullscreen_a = 0;

Future<bool> _checkStatusSee() async {
  bool isAuthenticate = false;
  var localAuth = LocalAuthentication();
  try {
    isAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to login', stickyAuth: true);
    print('isAuthenticate: ' + isAuthenticate.toString());
  } on PlatformException catch (e) {
    print(e);
  }
  if(isAuthenticate) return true;
  else return false;
}

class Coursedetail extends StatefulWidget {
  @override
  _CoursedetailState createState() => _CoursedetailState();
}

class _CoursedetailState extends State<Coursedetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var size = MediaQuery.of(context).size;

    TextStyle maintextstyle = new TextStyle(
        color: Colors.black,
        fontSize: 17 * size.width / 390,
        fontWeight: FontWeight.bold);
    TextStyle subtextstyle =
        new TextStyle(color: Colors.black, fontSize: 17 * size.width / 390);
    if(purcahse != 1)
    {
      return Scaffold(
        key: _scaffoldKey,
        drawer: Menulist(),
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(20 * size.height / 750),
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    height: 80 * size.height / 750,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(_createRoutetomain());
                },
              ),
              //firsttext
              Container(
                padding: EdgeInsets.all(20 * size.width / 390),
                width: size.width,
                decoration: BoxDecoration(color: Colors.black87),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white, width: 3 * size.width / 390)),
                      child: Image.network(
                      'https://class.yixinacademy.com/assets/images/courses/${prizeimage[prizepos]}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20 * size.width / 390),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(prizeinfolist[0].firsttexttitle,
                              style: TextStyle(
                                  fontSize: 24 * size.width / 390,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10 * size.height / 750,
                          ),
                          Text(prizeinfolist[0].firsttext,
                              style: TextStyle(
                                  fontSize: 17 * size.width / 390,
                                  color: Colors.white,
                                  height: 2)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.6)),
                        width: 130 * size.width / 390,
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              size: 17 * size.width / 390,
                              color: Colors.white,
                            ),
                            Text(
                              '  Buy now',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17 * size.width / 390),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(_createRoutetobuy());
                      },
                    )
                  ],
                ),
              ),

              //secondtext
              SizedBox(
                height: 30 * size.height / 750,
              ),
              Container(
                padding: EdgeInsets.all(20 * size.width / 390),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Class List',
                      style: TextStyle(
                          fontSize: 22 * size.width / 390,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              for (int i = 0; i < classlist.length; i++) listclass(i, size),
              SizedBox(
                height: 60,
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.all(15 * size.width / 390),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 17 * size.width / 390, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: 120 * size.width / 390,
                      height: 3,
                      color: Colors.black87,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
//                      child: RichText(text:HTML.toTextSpan(context, catalog_detail,defaultTextStyle: TextStyle(fontSize: 15),)),
                        child: Html(data:catalog_detail),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      );
    }
    else
    {
      return Scaffold(
        key: _scaffoldKey,
        drawer: Menulist(),
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(20 * size.height / 750),
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    height: 80 * size.height / 750,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(_createRoutetomain());
                },
              ),
              //firsttext
              Container(
                padding: EdgeInsets.all(20 * size.width / 390),
                width: size.width,
                decoration: BoxDecoration(color: Colors.black87),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white, width: 3 * size.width / 390)),
                      child: Image.network(
                      'https://class.yixinacademy.com/assets/images/courses/${prizeimage[prizepos]}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20 * size.width / 390),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(prizeinfolist[0].firsttexttitle,
                              style: TextStyle(
                                  fontSize: 24 * size.width / 390,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10 * size.height / 750,
                          ),
                          Text(prizeinfolist[0].firsttext,
                              style: TextStyle(
                                  fontSize: 17 * size.width / 390,
                                  color: Colors.white,
                                  height: 2)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //secondtext
              SizedBox(
                height: 30 * size.height / 750,
              ),
              Container(
                padding: EdgeInsets.all(20 * size.width / 390),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Class List',
                      style: TextStyle(
                          fontSize: 22 * size.width / 390,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              for (int i = 0; i < classlist.length; i++) listclass(i, size),
              SizedBox(
                height: 60,
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.all(15 * size.width / 390),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 17 * size.width / 390, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: 120 * size.width / 390,
                      height: 3,
                      color: Colors.black87,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
//                      child: RichText(text:HTML.toTextSpan(context, catalog_detail,defaultTextStyle: TextStyle(fontSize: 15),)),
                      child: Html(data:catalog_detail),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      );
    }
  }

  Widget listclass(int num, size) {
    if(purcahse == 1 || everypur[num] == 1) {
      return Container(
        width: size.width,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300], width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classlist[num],
              style: TextStyle(
                  fontSize: 17 * size.width / 390,
                  color: Colors.black,
                  height: 1.5),
            ),
            Container(
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10 * size.width / 390,
                          10 * size.width / 390, 0, 10 * size.width / 390),
                      padding: EdgeInsets.fromLTRB(
                          15 * size.width / 390,
                          9 * size.width / 390,
                          15 * size.width / 390,
                          9 * size.width / 390),
                      width: 130 * size.width / 390,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0, 0))
                          ],
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(5 * size.width / 390))),
                      child: Row(
                        children: [
                            Icon(Icons.play_arrow,
                                size: 17 * size.width / 390, color: Colors.black),
                            Text(
                              ' play video',
                              style: TextStyle(
                                  fontSize: 17 * size.width / 390, color: Colors.black),
                            )
                        ],
                      ),

                    ),
                    onTap: () async{
                      if(await _checkStatusSee()) {
                        video_num = num;
                        Navigator.of(context).push(_createRoutetovideo());
                      }
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20 * size.width / 390,
                          10 * size.width / 390, 0, 10 * size.width / 390),
                      padding: EdgeInsets.fromLTRB(
                          15 * size.width / 390,
                          9 * size.width / 390,
                          15 * size.width / 390,
                          9 * size.width / 390),
                      width: 130 * size.width / 390,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0, 0))
                          ],
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(5 * size.width / 390))),
                      child: Row(
                        children: [
                            Icon(Icons.play_arrow,
                                size: 17 * size.width / 390, color: Colors.black),
                            Text(
                              ' play audio',
                              style: TextStyle(
                                  fontSize: 17 * size.width / 390, color: Colors.black),
                            )
                        ],
                      ),

                    ),
                    onTap: () async{
                      if(await _checkStatusSee()) {
                        video_num = num;
                        Navigator.of(context).push(_createRoutetoaudio());
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      );
      }
    else {
            return Container(
        width: size.width,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300], width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classlist[num],
              style: TextStyle(
                  fontSize: 17 * size.width / 390,
                  color: Colors.black,
                  height: 1.5),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.fromLTRB(180 * size.width / 390,
                    10 * size.width / 390, 0, 10 * size.width / 390),
                padding: EdgeInsets.fromLTRB(
                    15 * size.width / 390,
                    9 * size.width / 390,
                    15 * size.width / 390,
                    9 * size.width / 390),
                width: 130 * size.width / 390,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(0, 0))
                    ],
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(5 * size.width / 390))),
                child: Row(
                  children: [
                      Icon(Icons.shopping_cart,
                          size: 17 * size.width / 390, color: Colors.black),
                      Text(
                        '  Buy now',
                        style: TextStyle(
                            fontSize: 17 * size.width / 390, color: Colors.black),
                      )
                  ],
                ),

              ),
              onTap: () {},
            )
          ],
        ),
      );
    }
  }
}

Route _createRoutetomain() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Startpage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoutetobuy() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Buydetail(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoutetoaudio() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => showaudio(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoutetovideo() {
  fullscreen_v = 0;
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => showvideo(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
