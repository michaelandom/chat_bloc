import 'package:chat_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_bloc/bloc/chat/chat_bloc.dart';
import 'package:chat_bloc/bloc/steam/stream_cubit.dart';
import 'package:chat_bloc/db/k_shared_preference.dart';
import 'package:chat_bloc/presentation/widget/appbar.dart';
import 'package:chat_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HSharedPreference localPreference = GetHSPInstance.hSharedPreference;
  String currentUser;

  Future<String> userGet() async {
    currentUser = await localPreference.get(HSharedPreference.USER_NAME);
    BlocProvider.of<ChatBloc>(context).add(GetChatRoom(userName: currentUser));
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSignedOut) {
              Navigator.pushReplacementNamed(context, Routers.ROOT);
            }
          },
        ),
        BlocListener<StreamCubit, StreamState>(
          listener: (context, state) {
            if (state is StreamLoaded) {
              print("stream ${state.data.docs}");
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: appBarMain(context),
        body: FutureBuilder(
          future: userGet(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return BlocBuilder<StreamCubit, StreamState>(
              builder: (context, state) {
                if (state is StreamLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is StreamLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.data.docs.length,
                        itemBuilder: (context, index) {
                          String chatRoomId =
                              state.data.docs[index]["chatRoomId"];
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, Routers.CONVERSATION,
                                      arguments: chatRoomId)
                                  .whenComplete(() {
                                userGet();
                              });
                            },
                            leading: CircularProgressIndicator(),
                            title: Text(
                              state.data.docs[index]["userList"][0] ==
                                      currentUser
                                  ? state.data.docs[index]["userList"][1]
                                  : state.data.docs[index]["userList"][0],
                              style: mediumTextFormFiledStyle(),
                            ),
                            subtitle: Text(
                              "message",
                              style: mediumTextFormFiledStyle(),
                            ),
                          );
                        }),
                  );
                }
                if (state is ChatNotFound) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "no chat found",
                          style: simpleStyle(),
                        ),
                      ],
                    ),
                  );
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        snapshot.data,
                        style: simpleStyle(),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routers.SEARCH).whenComplete(() {
              BlocProvider.of<ChatBloc>(context)
                  .add(GetChatRoom(userName: currentUser));
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
