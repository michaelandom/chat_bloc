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
      if (result is List ? result.length > 0 : false) {
        yield ChatSingleResult(userList: result);
      } else if (result is List ? result.length == 0 : false) {
        yield ChatNotFound();
      } else {
        yield ChatError();
      }
    }
    if (event is ChatRoomCreate) {
      yield ChatLoading();
      final result = await dataBaseFunction.createChatRoom(event.userName);
      if (result) {
        yield ChatAdded();
      } else {
        yield ChatError();
      }
    }
    if (event is AddChatConversation) {
      yield ChatLoading();
      final result = await dataBaseFunction.addChatRoomChatList(
          event.chatRoomId, event.message);
      if (result) {
        yield AddedChatConversationState();
      } else {
        yield ChatError();
      }
    }
    if (event is GetChatConversation) {
      yield ChatLoading();
      final result =
          await dataBaseFunction.getChatRoomChatList(event.chatRoomId);
      if (result is List ? result.length > 0 : false) {
        yield GetChatConversationState(conversation: result);
      } else if (result is List ? result.length == 0 : false) {
        yield NoChatConversation();
      } else {
        yield ChatError();
      }
    }
    if (event is GetChatRoom) {
      yield ChatLoading();
      final result = await dataBaseFunction.getChatRoomList(event.userName);
      if (result is List ? result.length > 0 : false) {
        yield ChatResult(chatRoomList: result);
      } else if (result is List ? result.length == 0 : false) {
        yield ChatNotFound();
      } else {
        yield ChatError();
      }
    }
  }
}
