import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_bloc/db/k_shared_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'stream_state.dart';

class StreamCubit extends Cubit<StreamState> {
  HSharedPreference localPreference = GetHSPInstance.hSharedPreference;
  StreamSubscription streamSubscription;
  StreamCubit() : super(StreamLoading()) {
    f();
  }
  Future<void> f() async {
    final currentUser = await localPreference.get(HSharedPreference.USER_NAME);
    streamSubscription = FirebaseFirestore.instance
        .collection("chatRoom")
        .where("userList", arrayContains: currentUser)
        .snapshots()
        .listen((event) {
      if (event.docs != null) {
        emitInternetConnected(event);
      }
    });
  }

  void emitInternetConnected(dynamic _data) => emit(StreamLoaded(data: _data));
  @override
  Future<void> close() {
    // TODO: implement close
    streamSubscription.cancel();
    return super.close();
  }
}
