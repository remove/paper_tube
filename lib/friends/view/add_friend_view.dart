import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_tube/friends/bloc/add_friend_bloc.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:paper_tube/widget/avatar.dart';

class AddFriendView extends StatefulWidget {
  const AddFriendView({Key? key}) : super(key: key);

  @override
  _AddFriendViewState createState() => _AddFriendViewState();
}

class _AddFriendViewState extends State<AddFriendView> {
  final FocusNode _focusNode = FocusNode();
  String? _userId;

  @override
  void initState() {
    ServicesBinding.instance?.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
    IMCore().getUserId().then((value) => _userId = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: const Color.fromRGBO(240, 239, 244, 1),
        previousPageTitle: "联系人",
        middle: const Text("添加好友"),
      ),
      child: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _focusNode.unfocus(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                color: const Color.fromRGBO(240, 239, 244, 1),
                alignment: Alignment.topLeft,
                child: CupertinoSearchTextField(
                  focusNode: _focusNode,
                  prefixInsets: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  placeholder: "用户ID",
                  backgroundColor: const Color.fromRGBO(224, 223, 230, 1),
                  onSubmitted: (value) => context.read<AddFriendBloc>().add(
                        AddFriendSearched(value),
                      ),
                ),
              ),
              Expanded(
                child: BlocBuilder<AddFriendBloc, AddFriendState>(
                  builder: (context, state) {
                    if (state is AddFriendResult) {
                      if (state.v2timUserFullInfo != null) {
                        return ListView(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                              height: 70,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    child: Avatar(
                                      avatarUrl:
                                          state.v2timUserFullInfo!.faceUrl,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    state.v2timUserFullInfo!.nickName ??
                                        state.v2timUserFullInfo!.userID
                                            as String,
                                  ),
                                  Spacer(),
                                  buildAddButton(
                                    state.v2timUserFullInfo!.userID as String,
                                    state.friendExist,
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return ListView(
                          children: [
                            SizedBox(
                              height: 70,
                              child: Center(
                                child: Text(
                                  "该用户不存在",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddButton(String userId, bool friendExist) {
    TextEditingController controller = TextEditingController();
    controller.text = "你好，我是$_userId";
    return GestureDetector(
      onTap: () => showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text("验证信息"),
          content: Padding(
            padding: EdgeInsets.only(top: 10),
            child: CupertinoTextField(
              controller: controller,
              autofocus: true,
            ),
          ),
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.pop(_),
              child: Container(
                height: 40,
                alignment: Alignment.center,
                child: Text("取消", style: TextStyle(color: Colors.red)),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context
                    .read<AddFriendBloc>()
                    .add(AddFriendApplication(userId, controller.text));
                Navigator.pop(_);
              },
              child: Container(
                height: 40,
                alignment: Alignment.center,
                child: Text("发送", style: TextStyle(color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
      child: Container(
        child: Text(
          friendExist ? "已添加" : "添加",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
        decoration: BoxDecoration(
          color: friendExist ? Colors.grey[400] : Colors.cyan,
          borderRadius: BorderRadius.circular(7),
        ),
        alignment: Alignment.center,
        height: 32,
      ),
    );
  }
}
