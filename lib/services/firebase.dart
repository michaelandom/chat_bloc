import 'package:chat_bloc/db/k_shared_preference.dart';
import 'package:chat_bloc/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  HSharedPreference localPreference = GetHSPInstance.hSharedPreference;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DataBaseFunction dataBaseFunction = DataBaseFunction();
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final result = await dataBaseFunction.getUserByEmail(email);
      if (result != null) {
        print("${result["userName"]}${result["email"]}");
        localPreference.set(HSharedPreference.USER_NAME, result["userName"]);
      } else {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future signUpWithEmailAndPassword(
      String userName, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final result = await dataBaseFunction.uploadUserInfo(userName, email);
      localPreference.set(HSharedPreference.USER_NAME, userName);
      return result;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<bool> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userData =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userData.additionalUserInfo.isNewUser) {
        await dataBaseFunction.uploadUserInfo(
            userData.additionalUserInfo.profile["name"],
            userData.additionalUserInfo.profile["email"]);
        localPreference.set(HSharedPreference.USER_NAME,
            userData.additionalUserInfo.profile["name"]);
      } else {
        print(
            "userData.additionalUserInfo.providerId ${userData.additionalUserInfo.profile}");
        localPreference.set(HSharedPreference.USER_NAME,
            userData.additionalUserInfo.profile["name"]);
        // final result = await dataBaseFunction.getUserByEmail(userData.additionalUserInfo.profile["email"]);
        // print(
        //     "userData.additionalUserInfo.providerId ${userData.additionalUserInfo.profile}");
        // if (result != null) {
        //   print("$result");
        //   print("${result["userName"]}${result["email"]}");
        //   localPreference.set(HSharedPreference.USER_NAME, result["userName"]);
        // } else {
        //   return false;
        // }
      }
      return true;
    } catch (e) {
      print("error is $e");
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }
}
