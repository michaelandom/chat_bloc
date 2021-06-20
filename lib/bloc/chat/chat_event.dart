part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatRoomCreate extends ChatEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class AddChat extends ChatEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SearchUser extends ChatEvent{
  final String username;

  SearchUser({this.username});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

