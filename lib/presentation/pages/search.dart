import 'package:chat_bloc/bloc/chat/chat_bloc.dart';
import 'package:chat_bloc/presentation/widget/appbar.dart';
import 'package:chat_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController usernameCon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameCon = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatAdded) {
          Navigator.pushNamed(context, Routers.CONVERSATION,
              arguments: state.chatRoomId);
        }

        // TODO: implement listener}
      },
      child: Scaffold(
        appBar: appBarMain(context),
        body: Container(
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade600,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: usernameCon,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "search username",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          border: InputBorder.none),
                    )),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(40)),
                      child: IconButton(
                          onPressed: () {
                            BlocProvider.of<ChatBloc>(context)
                                .add(SearchUser(username: usernameCon.text));
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.white54,
                          )),
                    )
                  ],
                ),
              ),
              BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatSingleResult) {
                    print("state.userList ${state.userList}");
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.userList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                state.userList[index]["userName"],
                                style: mediumTextFormFiledStyle(),
                              ),
                              subtitle: Text(
                                state.userList[index]["email"],
                                style: mediumTextFormFiledStyle(),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<ChatBloc>(context).add(
                                      ChatRoomCreate(
                                          userName: state.userList[index]
                                              ["userName"]));
                                },
                                child: Text(
                                  "Message",
                                  style: mediumTextFormFiledStyle(),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  if (state is ChatLoading) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is ChatNotFound) {
                    return Center(
                      child: Text(
                        "chat not found",
                        style: simpleStyle(),
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
