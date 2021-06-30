import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'chat_stream_state.dart';

class ChatStreamCubit extends Cubit<ChatStreamState> {
  late StreamSubscription streamSubscription;
  final String chatRoomId;
  ChatStreamCubit({required this.chatRoomId})
      : super(ChatStreamStreamLoading()) {
    f();
  }
  Future<void> f() async {
    streamSubscription = FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots()
        .listen((event) {
      if (event.docs != null) {
        emitStreamLoaded(event);
      }
    });
  }

  void emitStreamLoaded(dynamic _data) => emit(ChatStreamLoaded(data: _data));
  @override
  Future<void> close() {
    // TODO: implement close
    streamSubscription.cancel();
    return super.close();
  }
}
