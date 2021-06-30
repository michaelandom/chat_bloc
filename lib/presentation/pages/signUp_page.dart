import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_bloc/presentation/widget/appbar.dart';
import 'package:chat_bloc/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController userController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> signUpForm = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedIn) {
            Navigator.pushReplacementNamed(context, Routers.HOME);
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
                    key: signUpForm,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: userController,
                          validator: (value) {
                            if (value!.length < 3) {
                              return "username cant be less than 3";
                            }
                            return null;
                          },
                          style: simpleTextFormFiledStyle(),
                          decoration: textFormFiledInputDecoration("Username"),
                        ),
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
                        TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.length < 6) {
                                return "password cant be less then 6";
                              }
                              return null;
                            },
                            style: simpleTextFormFiledStyle(),
                            decoration:
                                textFormFiledInputDecoration("password")),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  print("sd");
                                  if (signUpForm.currentState!.validate()) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                        EmailAndPasswordSignUpEvent(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            username: userController.text));
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
                                            "Sign Up",
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
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(GoogleSignInEvent());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Center(
                                      child: BlocBuilder<AuthBloc, AuthState>(
                                        builder: (context, state) {
                                          if (state is AuthLoading) {
                                            return CircularProgressIndicator();
                                          }
                                          return Text(
                                            "Sign In with Google",
                                            style: TextStyle(
                                              color: Colors.black,
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
                          height: 10,
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
