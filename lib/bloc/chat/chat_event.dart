part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatRoomCreate extends ChatEvent {
  final userName;

  ChatRoomCreate({this.userName});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetChatConversation extends ChatEvent {
  final chatRoomId;

  GetChatConversation({this.chatRoomId});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AddChatConversation extends ChatEvent {
  final String chatRoomId;
  final Map<String, dynamic> message;
  AddChatConversation({this.chatRoomId, this.message});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetChatRoom extends ChatEvent {
  final userName;

  GetChatRoom({this.userName});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AddChat extends ChatEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SearchUser extends ChatEvent {
  final String username;

  SearchUser({this.username});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
