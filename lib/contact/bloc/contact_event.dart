part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class ContactLoadCompleted extends ContactEvent {}