part of 'add_friend_bloc.dart';

@immutable
abstract class AddFriendEvent {}

class AddFriendSearched extends AddFriendEvent {
  final String userId;

  AddFriendSearched(this.userId);
}

class AddFriendApplication extends AddFriendEvent {
  final String userId;
  final String addNote;

  AddFriendApplication(this.userId, this.addNote);
}

