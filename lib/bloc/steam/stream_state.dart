part of 'stream_cubit.dart';

abstract class StreamState extends Equatable {
  const StreamState();
}

class StreamLoaded extends StreamState {
  final data;

  StreamLoaded({this.data});
  @override
  List<Object> get props => [data];
}

class StreamLoading extends StreamState {
  @override
  List<Object> get props => [];
}
