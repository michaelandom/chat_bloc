import 'package:chat_bloc/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DataBaseFunction dataBaseFunction = DataBaseFunction();
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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
            userData.additionalUserInfo.username,
            userData.additionalUserInfo.providerId);
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
