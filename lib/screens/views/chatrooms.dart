//import 'dart:html';
import 'dart:async';

import 'package:Juhuischool/screens/helper/authenticate.dart';
import 'package:Juhuischool/screens/helper/constants.dart';
import 'package:Juhuischool/screens/helper/helperfunctions.dart';
import 'package:Juhuischool/screens/helper/theme.dart';
import 'package:Juhuischool/screens/services/auth.dart';
import 'package:Juhuischool/screens/services/database.dart';
import 'package:Juhuischool/screens/views/chat.dart';
import 'package:Juhuischool/screens/views/search.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../chatEvent/chatevent.dart';

QuerySnapshot querySnapshot;
List<QuerySnapshot> userquerySnapshot = [];
List<UnRead> unreadmessage = [];
List<String> chatroomlist = [];
int chat_first_load = 0;

class UnRead {
  String name;
  int cnt;
  UnRead({@required this.name,@required this.cnt});
}

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;
  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  int sendunreadcnt = 0;
                  for(int i = 0;i < unreadmessage.length; i++) {
                    if(unreadmessage[i].name == snapshot.data.documents[index].data['chatRoomId'].toString())
                    {
                      sendunreadcnt = unreadmessage[i].cnt;
                      print(sendunreadcnt.toString());
                      break;
                    }
                  }
                  return ChatRoomsTile(
                    userName: snapshot.data.documents[index].data['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId: snapshot.data.documents[index].data["chatRoomId"],
                    userunreadmessage: sendunreadcnt,
                  );
                })
            : Container();
      },
    );
  }

  void changeevent() {  
    CollectionReference reference = Firestore.instance.collection('chatRoom');
    reference.snapshots().listen((chagequery) {
      chagequery.documentChanges.forEach((change) async{
        bool flg = false;
        for(int i = 0;i < unreadmessage.length; i++) {
          if(unreadmessage[i].name == change.document.documentID) {
            unreadmessage[i].cnt = 0;
            flg = true;
          }
        }
        if(!flg) {
          UnRead insertitem = new UnRead(name: change.document.documentID, cnt: 0);
          unreadmessage.add(insertitem);
        }
        await DatabaseMethods().getUnreadMessage(change.document.documentID,change.document.documentID.toString().replaceAll("_", "").replaceAll(Constants.myName, "")).then((userunread){
//          unreadmessage[chatroomlist.indexOf(change.document.documentID)] = unread.documents.length;

          for(int i = 0;i < unreadmessage.length; i++) {
            if(unreadmessage[i].name == change.document.documentID) {
              unreadmessage[i].cnt = userunread.documents.length;
              print(userunread.documents.length);
            }
          }
          setState(() {});
        });
      });
    });
  }

  @override
  void initState() {
    changeevent();
    unreadmessage.clear();
    chatroomlist.clear();
    getUserChatRoom();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // animationController.dispose() instead of your controller.dispose 
  }

  getUserChatRoom() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print("we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
    firstupdate();
  }

  firstupdate() async {
    if(chat_first_load == 0) {
      Constants.myName = await HelperFunctions.getUserNameSharedPreference();
      await DatabaseMethods().getUserChatlist(Constants.myName).then((snapshots) async{
        for(int i = 0;i < snapshots.documents.length; i++) {
//          UnRead insertitem = new UnRead(name: snapshots.documents[i].documentID.toString(), cnt: 0);
//          unreadmessage.add(insertitem);
          await DatabaseMethods().getUnreadMessage(snapshots.documents[i].documentID,snapshots.documents[i].documentID.toString().replaceAll("_", "").replaceAll(Constants.myName, "")).then((userunread){
            for(int j = 0;j < unreadmessage.length; j++)
            {
              if(unreadmessage[j].name == snapshots.documents[i].documentID)
                unreadmessage[j].cnt = userunread.documents.length;
            }
            setState(() {});
            chat_first_load++;
          });
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(Constants.myName + " is Log In"),
        elevation: 0.0,
        centerTitle: true,
      ),
      drawer: Menulist(),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
    );
  }
}


class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  final int userunreadmessage;

  ChatRoomsTile({this.userName,@required this.chatRoomId, @required this.userunreadmessage});
  @override
  Widget build(BuildContext context) {
    chatroomlist.add(chatRoomId);
    print(userunreadmessage);
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Chat(
            chatRoomId: chatRoomId,
          )
        ));
      },
      child: Container(
        color: Colors.black12,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: CustomTheme.colorAccent,
                  borderRadius: BorderRadius.circular(40)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.bold)),
            Spacer(),
            userunreadmessage != 0 ? Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: CustomTheme.colorAccent,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(userunreadmessage.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
