part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class MessageLoadCompleted extends MessageEvent {}

class MessageReceivedFromIMCore extends MessageEvent {
  MessageReceivedFromIMCore(this.messageRecord);

  final MessageRecord messageRecord;
}
