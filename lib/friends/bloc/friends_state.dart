part of 'friends_bloc.dart';

@immutable
abstract class FriendsState {}

class FriendsInitial extends FriendsState {}

class FriendsListening extends FriendsState {}

class FriendsReceivedNewApplication extends FriendsState {
  final List<Friend> friends;

  FriendsReceivedNewApplication(this.friends);
}

class FriendsReceivedDelApplication extends FriendsState {
  final String userId;

  FriendsReceivedDelApplication(this.userId);
}

class FriendsListRefresh extends FriendsState {}

class FriendsDeletedAfterPopPage extends FriendsState {}
