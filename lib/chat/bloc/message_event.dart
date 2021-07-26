part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class MessageLoadCompleted extends MessageEvent {}

class MessageReceivedFromIMCore extends MessageEvent {
  final MessageRecord messageRecord;

  MessageReceivedFromIMCore(this.messageRecord);
}

class MessageReceivedFromKeyBoard extends MessageEvent {
  final String text;

  MessageReceivedFromKeyBoard(this.text);
}
