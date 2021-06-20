part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatSingleResult extends ChatState {
  final List userList;
  ChatSingleResult({this.userList});
  @override
  List<Object> get props => [];
}

class ChatResult extends ChatState {
  final List chatRoomList;

  ChatResult({this.chatRoomList});
  @override
  List<Object> get props => [];
}

class ChatNotFound extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatAdded extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatError extends ChatState {
  @override
  List<Object> get props => [];
}
