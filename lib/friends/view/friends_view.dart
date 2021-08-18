import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:paper_tube/friends/bloc/add_friend_bloc.dart';
import 'package:paper_tube/friends/bloc/friends_bloc.dart';
import 'package:paper_tube/friends/view/add_friend_view.dart';
import 'package:paper_tube/friends/view/friend_detail_view.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:paper_tube/models/friend_dao.dart';
import 'package:paper_tube/route/aero_page_route.dart';
import 'package:paper_tube/widget/avatar.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info.dart';

class FriendsView extends StatefulWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
  List<FriendData> _friends = [];
  List<Friend> _newFriends = [];
  List<String> _tagList = [];

  _getNewFriendsList(BuildContext context) async {
    _newFriends.clear();
    var friendsList = await IMCore().getNewFriendsApplicationList();
    if (friendsList != null) {
      for (Friend friend in friendsList) {
        _newFriends.add(friend);
      }
    }
    context.read<FriendsBloc>().add(FriendsLoadCompleted());
  }

  _getFriendsList(BuildContext context) async {
    _friends.clear();
    var friendList = await IMCore().getFriendList();
    if (friendList != null) {
      for (V2TimFriendInfo friend in friendList) {
        _friends.add(
          FriendData(
            nickName: friend.userProfile?.nickName,
            friendRemark: friend.friendRemark,
            avatarUrl: friend.userProfile?.faceUrl,
            userID: friend.userID,
          ),
        );
      }
      SuspensionUtil.sortListBySuspensionTag(_friends);
      SuspensionUtil.setShowSuspensionStatus(_friends);
      _tagList = SuspensionUtil.getTagIndexList(_friends);
    }
    context.read<FriendsBloc>().add(FriendsLoadCompleted());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        brightness: Brightness.light,
        middle: const Text("联系人"),
        trailing: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.push(
            context,
            AeroPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => AddFriendBloc(),
                child: AddFriendView(),
              ),
            ),
          ),
          child: const SizedBox(
            width: 50,
            height: 40,
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(CupertinoIcons.add, size: 25),
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<FriendsBloc, FriendsState>(
          builder: (context, state) {
            if (state is FriendsInitial) {
              _getFriendsList(context);
              _getNewFriendsList(context);
            } else if (state is FriendsReceivedNewApplication) {
              _newFriends.removeWhere(
                  (element) => element.userId == state.friends[0].userId);
              _newFriends.insert(0, state.friends[0]);
            } else if (state is FriendsReceivedDelApplication) {
              _newFriends
                  .removeWhere((element) => element.userId == state.userId);
            } else if (state is FriendsListRefresh) {
              _getFriendsList(context);
              _getNewFriendsList(context);
            }
            return Column(
              children: [
                Container(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: CupertinoSearchTextField(),
                ),
                ...buildNewFriendsList(context),
                Expanded(
                  child: AzListView(
                    susItemHeight: 30,
                    susItemBuilder: (context, index) {
                      return buildSusItem(context, index);
                    },
                    physics: AlwaysScrollableScrollPhysics(),
                    indexBarData: _tagList,
                    data: _friends,
                    itemCount: _friends.length,
                    itemBuilder: (context, index) {
                      return buildFriends(index);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> buildNewFriendsList(BuildContext context) {
    List<Widget> widgetList = [];
    for (Friend friend in _newFriends) {
      widgetList.add(
        Container(
          padding: EdgeInsets.only(left: 12, right: 12),
          height: 50,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 12, 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Avatar(avatarUrl: friend.avatarUrl),
                ),
              ),
              Text(
                friend.nickName ?? friend.userId as String,
                style:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? const TextStyle(color: Colors.white)
                        : const TextStyle(color: Colors.black),
              ),
              Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
                onPressed: () => context
                    .read<FriendsBloc>()
                    .add(FriendsRejected(friend.userId as String)),
                child: Text(
                  "拒绝",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 5),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
                onPressed: () => context
                    .read<FriendsBloc>()
                    .add(FriendsAllowed(friend.userId as String)),
                child: Text(
                  "同意",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
    }
    return widgetList;
  }

  Widget buildFriends(int index) {
    final FriendData friend = _friends[index];
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        AeroPageRoute(
          builder: (_) => BlocProvider.value(
            value: context.read<FriendsBloc>(),
            child: FriendDetailView(
              friend: friend,
            ),
          ),
        ),
      ),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Avatar(avatarUrl: friend.avatarUrl),
              ),
            ),
            Text(
              friend.friendRemark ?? friend.userID,
              style:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? const TextStyle(color: Colors.white)
                      : const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSusItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(left: 14),
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      height: 30,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          _friends[index].getSuspensionTag(),
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}

class FriendData extends ISuspensionBean {
  String? nickName;
  String? friendRemark;
  String? avatarUrl;
  String userID;

  FriendData({
    required this.nickName,
    required this.friendRemark,
    required this.avatarUrl,
    required this.userID,
  });

  String transChineseToPinYin() {
    if (ChineseHelper.isChinese(friendRemark ?? "")) {
      return PinyinHelper.getFirstWordPinyin(friendRemark as String);
    } else {
      return friendRemark ?? userID;
    }
  }

  @override
  String getSuspensionTag() =>
      transChineseToPinYin().substring(0, 1).toUpperCase();
}
