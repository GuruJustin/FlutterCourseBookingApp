import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';

class Forgetpassword extends StatefulWidget {
  @override
  _ForgetpasswordState createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkboxvalue = true;
  void reset() {
    setState(() {});
  }

  String fullname = '';

  String password = '';
  void changename(value) {
    fullname = value;
    reset();
  }

  void changepassword(value) {
    password = value;
    reset();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var size = MediaQuery.of(context).size;
    TextStyle textStyle =
        new TextStyle(color: Colors.black, fontSize: 20 * size.width / 390);
    return Scaffold(
        key: _scaffoldKey,
        drawer: Menulist(),
        resizeToAvoidBottomPadding: true,
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(
                      height: 60 * size.height / 750,
                    ),
                    Container(
                      child: Text(
                        'FORGOT PASSWORD',
                        style: TextStyle(
                            fontSize: 27 * size.width / 390,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10 * size.height / 750,
                    ),
                    Container(
                      child: Text(
                        'Please Write Your Email',
                        style: TextStyle(
                            fontSize: 18 * size.width / 390,
                            color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 40 * size.height / 750),
                    CustomTextField(
                        'Email Address', Icons.person, context, changename),
                    SizedBox(height: 20 * size.height / 750),
                    Container(
                      height: 40,
                      width: size.width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 180 * size.width / 390,
                            child: Container(
                                width: 200 * size.width / 390,
                                child: GestureDetector(
                                  child: Text(
                                    'Login Now',
                                    style: textStyle,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20 * size.height / 750),
                    //login button

                    FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.of(context).push(_createRoutetomain());
                          registered = true;
                        },
                        child: Container(
                          color: Colors.black,
                          width: size.width,
                          height: 60 * size.height / 750,
                          alignment: Alignment.center,
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    SizedBox(height: 10 * size.height / 750),

                    SizedBox(
                      height: 20,
                    )
                  ]),
            ),
          ),
        ));
  }

  Widget CustomTextField(
      String _hint, IconData _iconData, BuildContext context, Function submit,
      {bool isObscureText = false, bool readonly = false}) {
    var theme = Theme.of(context);
    var colorSurface = theme.colorScheme.onSurface;
    TextStyle textStyle = TextStyle(
        color: colorSurface, fontFamily: 'Roboto-Regular', fontSize: 18);
    var size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size.width,
          height: 60 * size.height / 750,
          decoration: BoxDecoration(
              color: Colors.blue[50].withOpacity(0.4),
              border: Border.all(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.black.withOpacity(0.4))),
        ),
        TextField(
            onChanged: (value) {
              setState(() {
                submit(value);
              });
            },
            readOnly: readonly,
            obscureText: isObscureText,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            style: textStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                icon: Padding(
                  padding: EdgeInsets.only(left: 20 * size.width / 390),
                  child: Icon(_iconData, color: colorSurface),
                ),
                contentPadding: EdgeInsets.only(top: 3),
                hintStyle: textStyle,
                hintText: '$_hint')),
      ],
    );
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
