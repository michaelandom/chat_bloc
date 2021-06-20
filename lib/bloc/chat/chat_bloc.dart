import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_bloc/services/database.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  DataBaseFunction dataBaseFunction = DataBaseFunction();
  ChatBloc() : super(ChatInitial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is SearchUser) {
      yield ChatLoading();
      final result = await dataBaseFunction.getUserByUsername(event.username);
      if (result != null && result != false) {
        yield ChatSingleResult(
            email: result["email"], userName: result["userName"]);
      } else if (result == null) {
        yield ChatNotFound();
      } else {
        yield ChatError();
      }
    }
  }
}
