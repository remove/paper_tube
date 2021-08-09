part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactListening extends ContactState {}

class ContactResult extends ContactState {
  final V2TimUserFullInfo v2timUserFullInfo;

  ContactResult(this.v2timUserFullInfo);
}
