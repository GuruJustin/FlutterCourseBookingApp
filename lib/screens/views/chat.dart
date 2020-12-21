import 'dart:io';
import 'package:Juhuischool/screens/helper/constants.dart';
import 'package:Juhuischool/screens/services/database.dart';
import 'package:Juhuischool/screens/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore    
import 'package:image_picker/image_picker.dart'; // For Image Picker    
import 'package:Juhuischool/screens/views/image_view_page.dart';
import 'package:Juhuischool/screens/views/chatrooms.dart';
import 'package:path/path.dart' as Path; 

import '../chatEvent/chatevent.dart';

int sendedMessage = 0;
bool sendtype = false;

class Chat extends StatefulWidget {
  final String chatRoomId;

  Chat({this.chatRoomId});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  ScrollController _chatScrollController = ScrollController();
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  File _image;
  String _uploadedFileURL;

  Widget chatMessages(context){
    sendedMessage = 0;
    return Container(
      child:StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        if (_chatScrollController.hasClients)
          _chatScrollController.jumpTo(_chatScrollController.position.maxScrollExtent);
        setMessage();
        return snapshot.hasData ?  ListView.builder(
          controller: _chatScrollController,
          itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              Chatevent.messageReceived.value = "aa";
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              Chatevent.messageReceived.notifyListeners();
              return MessageTile(
                  message: snapshot.data.documents[index].data["message"],
                  url: snapshot.data.documents[index].data["url"],
                  read: snapshot.data.documents[index].data["read"],
                  chatRoomId: widget.chatRoomId,
                  sendByMe: Constants.myName == snapshot.data.documents[index].data["sendBy"],
                  last: index == snapshot.data.documents.length-1 ? 108.0 : 8.0,
              );
            }
          ) : Container();
      },),
    );
  }

  setMessage() async {
    await DatabaseMethods().getChatlists(widget.chatRoomId).then((usersnapshots) async{
      for(int j = 0;j < usersnapshots.documents.length; j++) {
        if(usersnapshots.documents[j].data["sendBy"] != Constants.myName) {
          await DatabaseMethods().setUserReadMessage(widget.chatRoomId,usersnapshots.documents[j].documentID);
        }
      }
    });
    await DatabaseMethods().setlastvisitmessage(widget.chatRoomId,DateTime.now().millisecondsSinceEpoch.toString());
  }
  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        "read": 1,
        'time': DateTime
            .now()
            .millisecondsSinceEpoch,
      };


      if(sendedMessage == 1 && sendtype == true) sendedMessage = 0;
      else {
         DatabaseMethods().addUserMessage(widget.chatRoomId, chatMessageMap, DateTime.now().millisecondsSinceEpoch.toString());
      }

      setState(() {
        messageEditingController.text = "";
      });
    }
//    _chatScrollController.jumpTo(_chatScrollController.position.maxScrollExtent + 120);
  }
  addImage() async{
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {    
      setState(() {    
        _image = image;    
      });
    });
    StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('chats/${Path.basename(_image.path)}}');    
    StorageUploadTask uploadTask = storageReference.putFile(_image);    
    await uploadTask.onComplete;    
    print('File Uploaded');    
    await storageReference.getDownloadURL().then((fileURL) {    
     setState(() {    
       _uploadedFileURL = fileURL;    
     });
    });
    Map<String, dynamic> chatMessageMap = {
      "sendBy": Constants.myName,
      "url": _uploadedFileURL,
      "read": 1,
      'time': DateTime
          .now()
          .millisecondsSinceEpoch,
    };
    if(sendedMessage == 1 && sendtype == true) sendedMessage = 0;
    else if(_uploadedFileURL != null) await DatabaseMethods().addUserMessage(widget.chatRoomId, chatMessageMap, DateTime.now().millisecondsSinceEpoch.toString());
//    _chatScrollController.jumpTo(_chatScrollController.position.maxScrollExtent+200);
  }

  @override
  void initState() {
    sendedMessage = 0;
    sendtype = false;
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    setMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with " + widget.chatRoomId.toString().replaceAll("_", "").replaceAll(Constants.myName, "")),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(context),
            Container(alignment: Alignment.bottomCenter,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                color: Color(0x54FFFFFF),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        addImage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36000000),
                                    const Color(0x0F000000)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(12),
                          child: Image.asset("assets/images/camera.png",
                            height: 25, width: 25,)),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                        child: TextField(
                          controller: messageEditingController,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          onSubmitted: (value) {
                            addMessage();
                          },
                          decoration: InputDecoration(
                              hintText: "Message ...",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        )),
                    SizedBox(width: 16,),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF5024ff),
                                    const Color(0xFF5024ff)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(12),
                          child: Image.asset("assets/images/send.png",
                            height: 25, width: 25,)),
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

class MessageTile extends StatelessWidget {
  final String message;
  final String url;
  final String chatRoomId;
  final bool sendByMe;
  final int read;
  final double last;

  MessageTile({@required this.message,@required this.url,@required this.read,@required this.chatRoomId, @required this.sendByMe, @required this.last});

  @override
  Widget build(BuildContext context) {
    if(message != null)
    {
      sendedMessage++;
      sendtype = sendByMe;
      return Container(
        padding: EdgeInsets.only(
            top: 8,
            bottom: last,
            left: sendByMe ? 0 : 24,
            right: sendByMe ? 24 : 0),
        alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: sendByMe
              ? EdgeInsets.only(left: 30)
              : EdgeInsets.only(right: 30),
          padding: EdgeInsets.only(
              top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: sendByMe ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23)
              ) :
              BorderRadius.only(
          topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomRight: Radius.circular(23)),
              gradient: LinearGradient(
                colors: sendByMe ? [
                  const Color(0xff007EF4),
                  const Color(0xff2A75BC)
                ]
                    : [
                  const Color(0x6A000000),
                  const Color(0x6A000000)
                ],
              )
          ),
          child: Text(message,
              textAlign: TextAlign.start,
              style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'OverpassRegular',
              fontWeight: FontWeight.w300)),
        ),
      );
    }
    else
    {
      sendedMessage++;
      sendtype = sendByMe;
      return Container(
        padding: EdgeInsets.only(
            top: 8,
            bottom: last,
            left: sendByMe ? 0 : 24,
            right: sendByMe ? 24 : 0),
        alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: sendByMe
              ? EdgeInsets.only(left: 30)
              : EdgeInsets.only(right: 30),
          padding: EdgeInsets.only(
              top: 10, bottom: 10, left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: sendByMe ? BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)
              ) :
              BorderRadius.only(
          topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15)),
              gradient: LinearGradient(
                colors: sendByMe ? [
                  const Color(0xff007EF4),
                  const Color(0xff2A75BC)
                ]
                    : [
                  const Color(0x6A000000),
                  const Color(0x6A000000)
                ],
              )
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) =>
                  ImageViewPage(
                    url: url
                  )
                )
              );
            },
            child: Image.network(    
              url,    
              height: 150,    
            ),
          ),
        ),
      );
    }
  }
}

