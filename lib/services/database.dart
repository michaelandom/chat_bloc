import 'package:chat_bloc/db/k_shared_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseFunction {
  HSharedPreference localPreference = GetHSPInstance.hSharedPreference;

  Future<dynamic> getUserByUsername(String userName) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection("users")
          .where("userName", isGreaterThanOrEqualTo: userName)
          .where("userName", isLessThan: userName + 'z')
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

  Future<String> createChatRoom(String userName) async {
    final currentUser = await localPreference.get(HSharedPreference.USER_NAME);
    List userList = [userName, currentUser];
    Map<String, dynamic> userMap = {
      "userList": userList,
      "chatRoomId": "$userName-$currentUser"
    };
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("chatRoom")
        .doc("$userName-$currentUser");
    DocumentReference documentReferenceRev = FirebaseFirestore.instance
        .collection("chatRoom")
        .doc("$currentUser-$userName");

    final result =
        await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      DocumentSnapshot snapshotRev =
          await transaction.get(documentReferenceRev);
      if (!snapshot.exists && !snapshotRev.exists) {
        try {
          await FirebaseFirestore.instance
              .collection("chatRoom")
              .doc("$userName-$currentUser")
              .set(userMap);
          return "$userName-$currentUser";
        } catch (e) {
          print(e);
          return null;
        }
      }
      if (snapshot.exists) {
        return "$userName-$currentUser";
      } else {
        return "$currentUser-$userName";
      }
    }).catchError((e) {
      print(e);
      return null;
    });
    return result;
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
