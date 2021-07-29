import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper_tube/chat/view/chat_view.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';

class ContactListWidget extends StatelessWidget {
  const ContactListWidget({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  final V2TimConversation conversation;

  String getAvatarUrl() {
    return conversation.faceUrl ??
        "https://cdn.jsdelivr.net/gh/remove/remove@main/user.png";
  }

  String getNickName() {
    return conversation.showName ?? (conversation.userID as String);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).push(
          AeroPageRoute(
            builder: (context) {
              return ContactView(
                userId: conversation.userID as String,
                nickName: getNickName(),
                avatarUrl: getAvatarUrl(),
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Image.network(getAvatarUrl()),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getNickName(),
                      style: TextStyle(
                        color: CupertinoTheme.brightnessOf(context) ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    Text(
                      conversation.lastMessage?.textElem?.text ?? "",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              constraints:
                  BoxConstraints(minWidth: 20, minHeight: 20, maxHeight: 20),
              padding: EdgeInsets.all(3),
              child: Text(
                "1",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 70, 95, 1),
                borderRadius: BorderRadius.all(Radius.circular(6)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(255, 70, 95, 0.3),
                      blurRadius: 8,
                      offset: Offset(1, 1))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AeroPageRoute extends PageRoute with CupertinoRouteTransitionMixin {
  AeroPageRoute({required this.builder, this.title});

  final WidgetBuilder builder;

  @override
  Color? get barrierColor => Color.fromRGBO(0, 0, 0, 0.13);

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  final bool maintainState = true;

  @override
  final String? title;
}
