import 'package:chat_bloc/db/k_shared_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseFunction {
  HSharedPreference localPreference = GetHSPInstance.hSharedPreference;

  Future<dynamic> getUserByUsername(String userName) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection("users")
          .where("userName", isEqualTo: userName)
          .get();
      return userData.docs;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<dynamic> getUserByEmail(String email) async {
    try {
      final userData =
          await FirebaseFirestore.instance.collection("users").doc(email).get();

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
          .doc(email)
          .set(userMap);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> createChatRoom(String userName) async {
    final currentUser = await localPreference.get(HSharedPreference.USER_NAME);
    List userList = [userName, currentUser];
    Map<String, dynamic> userMap = {
      "userList": userList,
      "chatRoomId": "$userName-$currentUser"
    };
    try {
      await FirebaseFirestore.instance
          .collection("chatRoom")
          .doc("$userName-$currentUser")
          .set(userMap);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<dynamic> getChatRoomList(String userName) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection("chatRoom")
          .where("userList", arrayContains: userName)
          .get();
      return userData.docs;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<dynamic> getChatRoomChatList(String chatRomeId) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(chatRomeId)
          .collection("chats")
          .get();
      return userData.docs;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<dynamic> addChatRoomChatList(
      String chatRomeId, Map<String, dynamic> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(chatRomeId)
          .collection("chats")
          .add(map);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
