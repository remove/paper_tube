import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:paper_tube/models/friend_dao.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_application.dart';

part 'friends_event.dart';

part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc() : super(FriendsInitial()) {
    on((event, emit) {
      if (event is FriendsLoadCompleted) {
        emit(FriendsListening());
      } else if (event is FriendsAddApplication) {
        emit(FriendsReceivedNewApplication(event.friends));
      } else if (event is FriendsApplicationListDeletedFromImCore) {
        emit(FriendsReceivedDelApplication(event.userId));
      } else if (event is FriendsAllowed) {
        _allowNewFriendRequest(event.userId);
      } else if (event is FriendsRejected) {
        _rejectNewFriendRequest(event.userId);
      } else if (event is FriendsListReceivedRefreshFromIMCore) {
        emit(FriendsListRefresh());
      } else if (event is FriendsDeleted) {
        _delFriend(event.userId);
        emit(FriendsDeletedAfterPopPage());
      }
    });
    _friendListener();
  }

  final IMCore _imCore = IMCore();

  ///同意好友申请
  _allowNewFriendRequest(String userId) {
    _imCore.allowNewFriendApplication(userId);
  }

  ///拒绝好友身影
  _rejectNewFriendRequest(String userId) {
    _imCore.rejectNewFriendApplication(userId);
  }

  ///删除好友
  _delFriend(String userId) {
    _imCore.delFriend(userId);
  }

  ///监听好友关系状态
  _friendListener() {
    _imCore.addFriendStream.stream.listen((event) {
      ///监听到新的好友请求
      if (event is List<V2TimFriendApplication>) {
        event.removeWhere((element) => element.type == 2);
        if (event is FriendsApplicationListAddFromImCore) {
          add(FriendsAddApplication(List.of(event.map(
            (e) => Friend(
              avatarUrl: e.faceUrl,
              nickName: e.nickname,
              userId: e.userID,
            ),
          ))));
        }

        ///监听到删除好友请求列表
      } else if (event is FriendsApplicationListDeletedFromImCore) {
        add(event);
      } else if (event is FriendsListReceivedRefreshFromIMCore) {
        add(event);
      }
    });
  }
}
