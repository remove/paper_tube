import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';

part 'conversation_event.dart';

part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationInitial()) {
    on((event, emit) {
      if (event is ConversationLoadCompleted) {
        emit(ConversationListening());
      } else if (event is ConversationChangeFromIMCore) {
        emit(ConversationChanged(event.v2timConversation));
      } else if (event is ConversationMarkMessageRead) {
        _markMessageRead(event.userId);
      }
    });
    _receivedNewConversationFromIMCore();
  }

  _markMessageRead(String userId) {
    IMCore().markMessageRead(userId);
  }

  _receivedNewConversationFromIMCore() {
    IMCore().conversationStream.stream.listen((event) {
      add(ConversationChangeFromIMCore(event));
    });
  }
}
