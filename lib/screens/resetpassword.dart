import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:Juhuischool/screens/login2_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

_onBasicBotAlertPressed(context,fullname,password) {
  Alert(
    context: context,
    title: fullname,
    desc: password,
  ).show();
}
String r_password = '';
String r_confirmpassword = '';

Future userregister() async {
  final uri = 'https://class.yixinacademy.com/api/user/resetpassword';
  var  requestBody = {
    'mail' : user_email,
    'password' : r_password,
  };
  http.Response response = await http.post(uri,body: requestBody);

  var responseObj = json.decode(response.body);
  return responseObj;
}

class RestPassword extends StatefulWidget {
  @override
  _RestPasswordState createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void reset() {
    setState(() {});
  }


  void changepassword(value) {
    r_password = value;
    reset();
  }

  void changeconfirmpassword(value) {
    r_confirmpassword = value;
    reset();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var size = MediaQuery.of(context).size;
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
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'ResetPassword NOW',
                        style: TextStyle(
                            fontSize: 23 * size.width / 390,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    CustomTextField(
                        'Password', Icons.vpn_key, context, changepassword,
                        isObscureText: true),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField('Confirm Password', Icons.vpn_key, context,
                        changeconfirmpassword,
                        isObscureText: true),
                    SizedBox(height: 20 * size.height / 750),
                    FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () async{
                            if(r_password == '') _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("PasswordField is empty")));
                            else if(r_password != r_confirmpassword) _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Password Does Not Match")));
                            else {
                              var returnvalue = await userregister();
                              if(returnvalue == true) Navigator.of(context).push(_createRoutetomain());
                              else _onBasicBotAlertPressed(context,"Try Again",returnvalue.toString(),);
                            }
                        },
                        child: Container(
                          color: Colors.black,
                          width: size.width,
                          height: 60 * size.height / 750,
                          alignment: Alignment.center,
                          child: Text(
                            'Reset',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    SizedBox(height: 60 * size.height / 750),
                  ]),
            ),
          ),
        ));
  }

  //textfield
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
        if (readonly)
          Positioned(
            right: 10,
            child: ToggleButtons(
              children: [
              ],
            ),
          )
      ],
    );
  }

  Widget CustomTextFielddate(
      String _hint, IconData _iconData, BuildContext context, Function submit,
      {bool isObscureText = false}) {
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
        TextFormField(
            readOnly: true,
            obscureText: isObscureText,
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
