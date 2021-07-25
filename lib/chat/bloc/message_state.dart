part of 'message_bloc.dart';

@immutable
abstract class MessageState {}

class MessageLoadDatabaseProgress extends MessageState {
  MessageLoadDatabaseProgress(this.initUserId);

  final String initUserId;
}

class MessageListening extends MessageState {}

class MessageReceived extends MessageState {
  MessageReceived(this.chatRecord);

  final MessageRecord chatRecord;
}
