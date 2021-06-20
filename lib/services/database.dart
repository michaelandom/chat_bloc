import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseFunction {
  Future<dynamic> getUserByUsername(String userName) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection("users")
          .doc(userName)
          .get();
      return userData;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadUserInfo(String userName, String email) async {
    Map<String, String> userMap = {"userName": userName, "email": email};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userName)
          .set(userMap);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> createChatRoom(String userName) async {
    List userList = [userName, FirebaseAuth.instance.currentUser.email];
    Map<String, dynamic> userMap = {
      "userList": userList,
      "chatRoomId": "$userName${FirebaseAuth.instance.currentUser.email}"
    };
    try {
      await FirebaseFirestore.instance
          .collection("chatRoom")
          .doc("$userName${FirebaseAuth.instance.currentUser.email}")
          .set(userMap);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
