import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_bloc/presentation/widget/appbar.dart';
import 'package:chat_bloc/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late TextEditingController emailController;
  GlobalKey<FormState> forgetPasswordForm = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthResetPassword) {
            Navigator.pushReplacementNamed(context, Routers.SIGN_IN);
          }
          if (state is AuthLoading || state is AuthLoadingEmail) {
            isLoading = true;
          } else {
            isLoading = false;
          }

          if (state is AuthError) {
            massageDialog(
                context, DialogType.ERROR, "Error", "there was an error!!!");
          }
        },
        child: AbsorbPointer(
          absorbing: isLoading,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: forgetPasswordForm,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: emailController,
                          style: simpleTextFormFiledStyle(),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value != null) {
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return "please enter a valid email";
                              }
                            }
                            return null;
                          },
                          decoration: textFormFiledInputDecoration("email"),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  if (forgetPasswordForm.currentState!
                                      .validate()) {
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(ResetPasswordEvent(
                                      email: emailController.text,
                                    ));
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: LinearGradient(
                                        colors: [
                                          Theme.of(context).primaryColor,
                                          Theme.of(context).accentColor,
                                        ],
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Center(
                                      child: BlocBuilder<AuthBloc, AuthState>(
                                        builder: (context, state) {
                                          if (state is AuthLoadingEmail) {
                                            return CircularProgressIndicator();
                                          }
                                          return Text(
                                            "Reset Password",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: mediumTextFormFiledStyle(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Routers.SIGN_IN);
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
