import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_tube/chat/bloc/message_bloc.dart';
import 'package:paper_tube/chat/view/chat_view.dart';
import 'package:paper_tube/friends/bloc/friends_bloc.dart';
import 'package:paper_tube/friends/view/friends_view.dart';
import 'package:paper_tube/route/aero_page_route.dart';
import 'package:paper_tube/widget/avatar.dart';

class FriendDetailView extends StatelessWidget {
  const FriendDetailView({
    Key? key,
    required this.friend,
  }) : super(key: key);

  final FriendData friend;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(primaryColor: Colors.white),
      child: CupertinoPageScaffold(
        backgroundColor: const Color.fromRGBO(237, 236, 242, 1),
        navigationBar: CupertinoNavigationBar(
          brightness: Brightness.dark,
          border: null,
          previousPageTitle: "联系人",
          backgroundColor: const Color.fromRGBO(0, 0, 0, .3),
          trailing: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              showCupertinoModalPopup<bool?>(
                context: context,
                builder: (BuildContext _) => CupertinoActionSheet(
                  title: const Text('更多'),
                  actions: <CupertinoActionSheetAction>[
                    CupertinoActionSheetAction(
                      child: const Text(
                        '删除好友',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        context
                            .read<FriendsBloc>()
                            .add(FriendsDeleted(friend.userID));
                        Navigator.pop(_, true);
                      },
                    )
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(_),
                    child: const Text(
                      '取消',
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                ),
              ).then((value) {
                if (value == true) Navigator.pop(context);
              });
            },
            child: const SizedBox(
              height: 40,
              width: 50,
              child: Align(
                alignment: Alignment.centerRight,
                child: const Text(
                  "更多",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Avatar(avatarUrl: friend.avatarUrl),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("备注", style: TextStyle(fontSize: 15)),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        friend.friendRemark ?? friend.userID,
                        style: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Icon(Icons.edit, size: 15, color: Colors.black26),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("昵称", style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(friend.nickName ?? "用户未设置昵称"),
                  const Divider(),
                  const Text("用户名", style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(friend.userID),
                ],
              ),
            ),
            const Spacer(),
            SafeArea(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  AeroPageRoute(
                    builder: (context) => BlocProvider(
                      create: (_) => MessageBloc(friend.userID),
                      child: ChatView(
                        nickName: friend.nickName ?? friend.userID,
                      ),
                    ),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.cyan),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "发消息",
                    style: TextStyle(color: Colors.cyan),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
