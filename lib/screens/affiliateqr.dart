import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:Juhuischool/screens/login2_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class structPageinfo {
  String pagetitle;
  int pageid;
  List<String> datadetail;
}


class Datastruct {
  List<String> data;
  int dataid;
}


class AffiliateQr extends StatefulWidget {
  @override
  _AffiliateQrState createState() => _AffiliateQrState();
}

class _AffiliateQrState extends State<AffiliateQr> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//data
//data
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var size = MediaQuery.of(context).size;
    var index = 0;
    return Scaffold(
        key: _scaffoldKey,
        drawer: Menulist(),
        resizeToAvoidBottomPadding: true,
        body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Center(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  //logo
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
                  SizedBox(
                    height: 20 * size.height / 750,
                  ),
                  
                  Container(
                    margin: EdgeInsets.only(top: 5 * size.height / 750),
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10 * size.height / 750)),
                        border: Border.all(width: 2, color: Colors.grey[300])),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: new TextFormField(
                            initialValue: 'https://class.yixinacademy.com/user/register/affiliate/${"user_id"}',
                            decoration: new InputDecoration(
                              labelText: "Enter Email",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                ),
                              ),
                            ),
                          ),
                        ),
                        QrImage(
                          data: 'https://class.yixinacademy.com/user/register/affiliate/${"user_id"}',
                          version: QrVersions.auto,
                          size: 320,
                          gapless: false,
                          embeddedImage: AssetImage('assets/qr.png'),
                          embeddedImageStyle: QrEmbeddedImageStyle(
                            size: Size(80, 80),
                          ),
                        )
                      ],
                    ),
                  ),
                  
                  SizedBox(
                    height: 20 * size.height / 750,
                  ),
                ],
              ),
            ))));
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

