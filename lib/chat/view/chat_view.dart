import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_tube/chat/bloc/message_bloc.dart';
import 'package:paper_tube/chat/widgets/inputBar.dart';
import 'package:paper_tube/chat/widgets/message_bubble.dart';
import 'package:paper_tube/models/friend_dao.dart';
import 'package:paper_tube/widget/avatar.dart';

class ChatView extends StatefulWidget {
  ChatView({
    Key? key,
    required this.nickName,
    this.avatarUrl,
  }) : super(key: key);
  final String nickName;
  final String? avatarUrl;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  List<MessageRecord> _messages = List.empty(growable: true);
  int limit = 20;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == 0) {
        context.read<MessageBloc>().add(MessageMoreHistoryLoad(limit, _messages.length));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        middle: Text(widget.nickName),
        trailing: Padding(
          padding: const EdgeInsets.only(bottom: 5, right: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Avatar(avatarUrl: widget.avatarUrl),
          ),
        ),
        previousPageTitle: "会话",
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            "images/background.jpg",
            fit: BoxFit.cover,
            height: _mediaQuery.size.height,
          ),
          Column(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _focusNode.unfocus(),
                  child: BlocBuilder<MessageBloc, MessageState>(
                    builder: (context, state) {
                      if (state is MessageHistoryPushToUI) {
                        _messages = state.messageRecord;
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                        });
                        context.read<MessageBloc>().add(MessageUILoadedCompleted());
                      } else if (state is MessageNewTextPushToUI) {
                        _messages.insert(0, state.chatRecord);
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            curve: const Cubic(.38, 0.7, 0.125, 1),
                            duration: const Duration(milliseconds: 390),
                          );
                        });
                        context.read<MessageBloc>().add(MessageUILoadedCompleted());
                      } else if (state is MessageMoreHistoryPushToUI) {
                        if (state.messageRecord.isNotEmpty) {
                          _messages.addAll(state.messageRecord);
                        }
                      }
                      return ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                          bottom: _mediaQuery.viewInsets.bottom + _mediaQuery.padding.bottom + 55,
                          top: 90,
                        ),
                        cacheExtent: double.maxFinite,
                        controller: _scrollController,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return MessageBubble(
                            messageRecord: _messages[_messages.length - 1 - index],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Builder(
            builder: (context) {
              if (_focusNode.hasFocus) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    curve: const Cubic(.38, 0.7, 0.125, 1),
                    duration: const Duration(milliseconds: 390),
                  );
                });
              }
              return InputBar(focusNode: _focusNode);
            },
          ),
        ],
      ),
    );
  }
}
