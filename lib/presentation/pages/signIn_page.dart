import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_bloc/presentation/widget/appbar.dart';
import 'package:chat_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> signInForm = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                context, DialogType.ERROR, "Error", "There was an error!!!");
          }
        },
        child: AbsorbPointer(
          absorbing: isLoading,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: signInForm,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routers.FORGET_PASSWORD);
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: simpleStyle(),
                                )),
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
                                  if (signInForm.currentState!.validate()) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                        EmailAndPasswordSignInEvent(
                                            email: emailController.text,
                                            password: passwordController.text));
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
                                            "Sign In",
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
                              "Don't have an account?",
                              style: mediumTextFormFiledStyle(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Routers.SIGN_UP);
                              },
                              child: Text(
                                "Register now",
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
