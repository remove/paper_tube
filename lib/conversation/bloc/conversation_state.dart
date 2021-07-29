part of 'conversation_bloc.dart';

@immutable
abstract class ConversationState {}

class ConversationInitial extends ConversationState {}

class ConversationListening extends ConversationState {}

class ConversationChanged extends ConversationState {
  final V2TimConversation v2timConversation;

  ConversationChanged(this.v2timConversation);
}
