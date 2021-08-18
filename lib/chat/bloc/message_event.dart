part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class MessageHistoryLoadedFromDatabase extends MessageEvent {}

class MessageUILoadedCompleted extends MessageEvent {}

class MessageReceivedFromIMCore extends MessageEvent {
  final MessageRecord messageRecord;

  MessageReceivedFromIMCore(this.messageRecord);
}

class MessageReceivedTextFromUI extends MessageEvent {
  final String text;

  MessageReceivedTextFromUI(this.text);
}

class MessageMoreHistoryLoad extends MessageEvent {
  final int limit;
  final int offset;

  MessageMoreHistoryLoad(this.limit, this.offset);
}
