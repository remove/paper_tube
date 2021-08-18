part of 'add_friend_bloc.dart';

@immutable
abstract class AddFriendState {}

class AddFriendInitial extends AddFriendState {}

class AddFriendResult extends AddFriendState {
  final V2TimUserFullInfo? v2timUserFullInfo;
  final bool friendExist;

  AddFriendResult(this.v2timUserFullInfo, this.friendExist);
}

class AddFriendApplicationSend extends AddFriendState {}
