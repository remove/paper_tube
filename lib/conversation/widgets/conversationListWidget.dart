import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_tube/chat/bloc/message_bloc.dart';
import 'package:paper_tube/chat/view/chat_view.dart';
import 'package:paper_tube/conversation/bloc/conversation_bloc.dart';
import 'package:paper_tube/route/aero_page_route.dart';
import 'package:paper_tube/widget/avatar.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';

class ContactListWidget extends StatelessWidget {
  const ContactListWidget({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  final V2TimConversation conversation;

  String getNickName() {
    return conversation.showName ?? (conversation.userID as String);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        context.read<ConversationBloc>().add(
              ConversationMarkMessageRead(conversation.userID as String),
            );
        Navigator.of(context).push(
          AeroPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (_) => MessageBloc(conversation.userID as String),
                child: ChatView(
                  nickName: getNickName(),
                  avatarUrl: conversation.faceUrl,
                ),
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
              child: Avatar(avatarUrl: conversation.faceUrl),
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
            if (conversation.unreadCount as int > 0)
              Container(
                alignment: Alignment.center,
                constraints:
                    BoxConstraints(minWidth: 20, minHeight: 20, maxHeight: 20),
                padding: EdgeInsets.all(3),
                child: Text(
                  conversation.unreadCount.toString(),
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
