import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar appBarMain(BuildContext context) {
  return AppBar(
    title: Text(
      "chart bloc",
      style:
          Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
    ),
    actions: [
      BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSignedIn) {
            return IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
              },
              icon: Icon(Icons.outbond),
            );
          }
          return Container();
        },
      ),
    ],
  );
}

InputDecoration textFormFiledInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.white54),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  );
}

TextStyle simpleStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle simpleTextFormFiledStyle() {
  return TextStyle(color: Colors.white, fontSize: 24);
}

TextStyle mediumTextFormFiledStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}

AwesomeDialog massageDialog(BuildContext context, DialogType dialogType,
    String title, String description) {
  return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: true,
      title: title,
      desc: description,
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red)
    ..show();
}
