part of 'message_bloc.dart';

@immutable
abstract class MessageState {}

class MessageListener extends MessageState {}

class MessageHistoryPushToUI extends MessageState {
  final List<MessageRecord> messageRecord;

  MessageHistoryPushToUI(this.messageRecord);
}

class MessageNewTextPushToUI extends MessageState {
  final MessageRecord chatRecord;

  MessageNewTextPushToUI(this.chatRecord);
}

class MessageMoreHistoryPushToUI extends MessageState {
  final List<MessageRecord> messageRecord;

  MessageMoreHistoryPushToUI(this.messageRecord);
}
