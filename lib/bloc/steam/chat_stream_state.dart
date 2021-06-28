part of 'chat_stream_cubit.dart';

abstract class ChatStreamState extends Equatable {
  const ChatStreamState();
}

class ChatStreamLoaded extends ChatStreamState {
  final data;

  ChatStreamLoaded({this.data});
  @override
  List<Object> get props => [data];
}

class ChatStreamStreamLoading extends ChatStreamState {
  @override
  List<Object> get props => [];
}
