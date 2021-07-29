part of 'conversation_bloc.dart';

@immutable
abstract class ConversationEvent {}

class ConversationLoadCompleted extends ConversationEvent {}

class ConversationChangeFromIMCore extends ConversationEvent {
  final V2TimConversation v2timConversation;

  ConversationChangeFromIMCore(this.v2timConversation);
}
