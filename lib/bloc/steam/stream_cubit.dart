import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_bloc/db/k_shared_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'stream_state.dart';

class StreamCubit extends Cubit<StreamState> {
  HSharedPreference localPreference = GetHSPInstance.hSharedPreference;
  Stream connectivityStream;
  StreamSubscription streamSubscription;
  StreamCubit() : super(StreamLoading()) {
    final currentUser = localPreference.get(HSharedPreference.USER_NAME);

    FirebaseFirestore.instance
        .collection("chatRoom")
        .where("userList", arrayContains: "tyu")
        .snapshots()
        .listen((event) {
      if (event.docs != null) {
        emitInternetConnected(event);
      }
    });
    // streamSubscription = connectivityStream.listen((event) {
    // });
  }
  void emitInternetConnected(dynamic _data) => emit(StreamLoaded(data: _data));
}
