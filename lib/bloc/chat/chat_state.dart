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
  ChatSingleResult({required this.userList});
  @override
  List<Object> get props => [userList];
}

class ChatResult extends ChatState {
  final List chatRoomList;
  ChatResult({required this.chatRoomList});
  @override
  List<Object> get props => [chatRoomList];
}

class ChatNotFound extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatUserNotFound extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatAdded extends ChatState {
  final String chatRoomId;

  ChatAdded({required this.chatRoomId});
  @override
  List<Object> get props => [chatRoomId];
}

class GetChatConversationState extends ChatState {
  final List conversation;

  GetChatConversationState({required this.conversation});

  @override
  List<Object> get props => [conversation];
}

class AddedChatConversationState extends ChatState {
  @override
  List<Object> get props => [];
}

class NoChatConversation extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatError extends ChatState {
  @override
  List<Object> get props => [];
}
