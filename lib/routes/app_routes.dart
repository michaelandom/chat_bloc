import 'package:chat_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_bloc/db/k_shared_preference.dart';
import 'package:chat_bloc/presentation/pages/forgetPassword_page.dart';
import 'package:chat_bloc/presentation/pages/home_page.dart';
import 'package:chat_bloc/presentation/pages/signIn_page.dart';
import 'package:chat_bloc/presentation/pages/signUp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routers {
  static const String HOME = "/home";
  static const String ROOT = "/";
  static const String SIGN_IN = "/signIn";
  static const String SIGN_UP = "/signUp";
  static const String FORGET_PASSWORD = "/forgetPassword";
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROOT:
        return MaterialPageRoute(
            builder: (_) => FutureBuilder(
                  builder: buildFirstPage,
                  future: isFirstTime(),
                ));
      case HOME:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case SIGN_IN:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case SIGN_UP:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case FORGET_PASSWORD:
        return MaterialPageRoute(builder: (_) => ForgetPasswordPage());
    }
  }

  Widget buildFirstPage(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.none &&
        snapshot.hasData == null) {
      return CircularProgressIndicator();
    } else if (snapshot.data == true) {
      BlocProvider.of<AuthBloc>(context).add(SignedInEvent());
      return MyHomePage();
    } else if (snapshot.data == false) {
      return SignInPage(); // change to home page
    } else {
      return Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()));
    }
  }

  Future<bool> isFirstTime() async {
    HSharedPreference localPreference = GetHSPInstance.hSharedPreference;
    return await localPreference
        .get(HSharedPreference.USER_STATES)
        .then((firstTime) => firstTime == null
            ? false
            : firstTime
                ? true
                : false);
  }
}
