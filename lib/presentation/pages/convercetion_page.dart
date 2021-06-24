import 'package:chat_bloc/bloc/chat/chat_bloc.dart';
import 'package:chat_bloc/db/k_shared_preference.dart';
import 'package:chat_bloc/presentation/widget/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  HSharedPreference localPreference = GetHSPInstance.hSharedPreference;
  String currentUser;
  String chatRoomId;
  TextEditingController messageController;
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  Future<String> userGet(BuildContext context) async {
    currentUser = await localPreference.get(HSharedPreference.USER_NAME);
    chatRoomId = ModalRoute.of(context).settings.arguments;
    print("chatRoomId $chatRoomId");
    BlocProvider.of<ChatBloc>(context)
        .add(GetChatConversation(chatRoomId: chatRoomId));
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: userGet(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("chatRoom")
                          .doc(chatRoomId)
                          .collection("chats")
                          .orderBy("time")
                          .snapshots(),
                      builder: (context, snapShot) {
                        final conversation =
                            snapShot.data != null ? snapShot.data.docs : null;

                        return conversation != null
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: conversation.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    alignment: currentUser !=
                                            conversation[index]["sendBy"]
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: currentUser !=
                                                    conversation[index]
                                                        ["sendBy"]
                                                ? Theme.of(context).accentColor
                                                : Theme.of(context)
                                                    .primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            conversation[index]["message"],
                                            style: mediumTextFormFiledStyle(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : Container();
                      });
                }),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.grey.shade600,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: messageController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "massage...",
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
                          if (messageController.text == "") {
                            return;
                          }

                          Map<String, dynamic> map = {
                            "message": messageController.text,
                            "sendBy": currentUser,
                            "time": DateTime.now().microsecondsSinceEpoch
                          };
                          BlocProvider.of<ChatBloc>(context).add(
                              AddChatConversation(
                                  chatRoomId: chatRoomId, message: map));
                          messageController.clear();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white54,
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
