part of 'friends_bloc.dart';

@immutable
abstract class FriendsEvent {}

class FriendsLoadCompleted extends FriendsEvent {}

class FriendsAddApplication extends FriendsEvent {
  final List<Friend> friends;

  FriendsAddApplication(this.friends);
}

class FriendsApplicationListDeletedFromImCore extends FriendsEvent {
  final String userId;

  FriendsApplicationListDeletedFromImCore(this.userId);
}

class FriendsApplicationListAddFromImCore extends FriendsEvent {
  final List<V2TimFriendApplication> applicationList;

  FriendsApplicationListAddFromImCore(this.applicationList);
}

class FriendsRejected extends FriendsEvent {
  final String userId;

  FriendsRejected(this.userId);
}

class FriendsAllowed extends FriendsEvent {
  final String userId;

  FriendsAllowed(this.userId);
}

class FriendsDeleted extends FriendsEvent {
  final String userId;

  FriendsDeleted(this.userId);
}

class FriendsListReceivedRefreshFromIMCore extends FriendsEvent {}
