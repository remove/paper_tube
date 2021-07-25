import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_tube/models/dao/get_database.dart';
import 'package:paper_tube/chat/bloc/message_bloc.dart';
import 'package:paper_tube/chat/widgets/inputBar.dart';
import 'package:paper_tube/chat/widgets/message_bubble.dart';
import 'package:paper_tube/models/dao/friendDAO.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({
    Key? key,
    required this.userId,
    required this.nickName,
    required this.avatarUrl,
  }) : super(key: key);
  final String userId;
  final String nickName;
  final String avatarUrl;

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  GlobalKey<InputBarState> _inputKey = GlobalKey();
  ScrollController _scrollController = ScrollController();
  List<MessageRecord> _messageList = [];
  double _keyBoardHeight = 40;

  @override
  Widget build(BuildContext context) {
    double _bottom = MediaQuery.of(context).viewInsets.bottom;
    if (_bottom != 0) {
      _keyBoardHeight = _bottom + 10;
    } else {
      _keyBoardHeight = 40;
    }
    return RepositoryProvider(
      create: (context) => GetDatabase(),
      child: BlocProvider(
        create: (context) => MessageBloc(widget.userId),
        child: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: EdgeInsetsDirectional.zero,
            middle: Column(
              children: [
                Text(
                  widget.nickName,
                ),
                Text(
                  "在线",
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(bottom: 5, right: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(widget.avatarUrl),
              ),
            ),
            previousPageTitle: "会话",
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _inputKey.currentState!.closeKeyBoard();
            },
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<MessageBloc, MessageState>(
                    builder: (context, state) {
                      ///从数据库获取历史聊天记录
                      if (state is MessageLoadDatabaseProgress) {
                        ///读取数据库
                        context
                            .read<GetDatabase>()
                            .myDatabase
                            .getChatContent(state.initUserId)
                            .then((value) {
                          _messageList = value;
                        });

                        ///消息读取完成通知BLOC
                        context.read<MessageBloc>().add(MessageLoadCompleted());

                        ///收到新消息
                      } else if (state is MessageReceived) {
                        ///消息加载
                        _messageList.add(state.chatRecord);

                        ///消息加载完成通知BLOC
                        context.read<MessageBloc>().add(MessageLoadCompleted());
                      }
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: _messageList.length,
                        itemBuilder: (context, index) {
                          return MessageBubble(
                            message: _messageList[index].content as String,
                            own: _messageList[index].self,
                          );
                        },
                      );
                    },
                  ),
                ),
                AnimatedPadding(
                  duration: Duration(milliseconds: 350),
                  curve: Curves.linearToEaseOut,
                  padding: EdgeInsets.only(bottom: _keyBoardHeight),
                  child: InputBar(key: _inputKey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
