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
  final String email;
  final String userName;
  ChatSingleResult({this.email, this.userName});
  @override
  List<Object> get props => [];
}

class ChatResult extends ChatState {
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
