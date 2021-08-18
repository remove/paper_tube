import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_tube/conversation/bloc/conversation_bloc.dart';
import 'package:paper_tube/conversation/widgets/conversationListWidget.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';

class ConversationView extends StatefulWidget {
  const ConversationView({Key? key}) : super(key: key);

  @override
  _ConversationViewState createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  List<V2TimConversation?>? _conversationList = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            stretch: true,
            largeTitle: Text("会话"),
          ),
          BlocProvider(
            create: (context) => ConversationBloc(),
            child: BlocBuilder<ConversationBloc, ConversationState>(
              builder: (context, state) {
                if (state is ConversationInitial) {
                  IMCore().getConversationList().then((value) {
                    _conversationList = value;
                    context
                        .read<ConversationBloc>()
                        .add(ConversationLoadCompleted());
                  });
                } else if (state is ConversationChanged) {
                  _conversationList!.removeWhere(
                    (element) =>
                        element!.userID == state.v2timConversation.userID,
                  );
                  _conversationList!.insert(0, state.v2timConversation);
                  context
                      .read<ConversationBloc>()
                      .add(ConversationLoadCompleted());
                }
                return SliverFixedExtentList(
                  itemExtent: 70,
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      if (_conversationList != null) {
                        if (index < _conversationList!.length) {
                          return ContactListWidget(
                            conversation:
                                _conversationList![index] as V2TimConversation,
                          );
                        }
                      } else {
                        return null;
                      }
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
