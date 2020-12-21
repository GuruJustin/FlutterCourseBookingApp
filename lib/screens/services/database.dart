import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async{
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addUserMessage(String chatRoomId, chatMessageData,String time) async{

    await Firestore.instance.collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
          print(e.toString());
    });
    
    await Firestore.instance.collection("chatRoom")
        .document(chatRoomId).updateData({"time":time});
        
  }

  getUserChats(String itIsMyName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  getUserChatlist(String itIsMyName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where("users", arrayContains: itIsMyName).getDocuments();
  }

  getChatlists(String chatRoomId) async{
    return await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .where('read', isEqualTo: 1)
        .getDocuments();
  }

  getUnreadMessage(String chatRoomId, String clientName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .where("read", isEqualTo: 1)
        .where("sendBy", isEqualTo: clientName)
        .getDocuments();
  }
  setlastvisitmessage(String chatRoomId,String time) async {
    await Firestore.instance.collection("chatRoom")
        .document(chatRoomId).updateData({"time":time});
  }
/*
  setlastvisitmessage(String chatRoomId,String time) async {
    await Firestore.instance.collection("chatRoom")
        .document(chatRoomId).updateData({"time":time});
  }
  
  setvisitmessage(String chatRoomId,String time) async {
    await Firestore.instance.collection("chatRoom")
        .document(chatRoomId).updateData({"time":time});
  }
*/
  setUserReadMessage(String chatRoomId,String userId) async{
    return await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .document(userId).updateData({"read":0});
  }
}
