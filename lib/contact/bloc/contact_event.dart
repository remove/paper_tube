part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class ContactLoadCompleted extends ContactEvent {}

class ContactAddInput extends ContactEvent {
  final String userId;

  ContactAddInput(this.userId);
}
