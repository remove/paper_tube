import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paper_tube/im/friend_check_type.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';

part 'add_friend_event.dart';

part 'add_friend_state.dart';

class AddFriendBloc extends Bloc<AddFriendEvent, AddFriendState> {
  AddFriendBloc() : super(AddFriendInitial());

  final IMCore _imCore = IMCore();

  Stream<AddFriendState> mapEventToState(
    AddFriendEvent event,
  ) async* {
    if (event is AddFriendSearched) {
      yield AddFriendResult(
        await IMCore().getUserInfo(event.userId),
        await _friendCheck(event.userId),
      );
    } else if (event is AddFriendApplication) {
      await _addFriend(event.userId, event.addNote);
      yield AddFriendApplicationSend();
    }
  }

  _addFriend(String userId, String addNote) async {
    await _imCore.addFriend(userId, addNote);
  }

  Future<bool> _friendCheck(String userId) async {
    var resultType = await _imCore.friendCheck(userId);
    if (resultType != null) {
      switch (resultType) {
        case FriendCheckType.V2TIM_FRIEND_RELATION_TYPE_NONE:
          return false;
        case FriendCheckType.V2TIM_FRIEND_RELATION_TYPE_IN_MY_FRIEND_LIST:
          return true;
        case FriendCheckType.V2TIM_FRIEND_RELATION_TYPE_IN_OTHER_FRIEND_LIST:
          return false;
        case FriendCheckType.V2TIM_FRIEND_RELATION_TYPE_BOTH_WAY:
          return true;
      }
    } else {
      return false;
    }
  }
}
