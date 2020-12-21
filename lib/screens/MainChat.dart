import 'package:Juhuischool/screens/helper/authenticate.dart';
import 'package:Juhuischool/screens/helper/helperfunctions.dart';
import 'package:Juhuischool/screens/views/chatrooms.dart';
import 'package:flutter/material.dart';


class MainChat extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MainChatState createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {

  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        accentColor: Color(0xff007EF4),
        fontFamily: "OverpassRegular",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn != null ?  userIsLoggedIn ? ChatRoom() : Authenticate()
          : Container(
        child: Center(
          child: Authenticate(),
        ),
      ),
    );
  }
}
