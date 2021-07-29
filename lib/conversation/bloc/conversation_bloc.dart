import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';

part 'conversation_event.dart';

part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationInitial()) {
    _receivedNewConversationFromIMCore();
  }

  @override
  Stream<ConversationState> mapEventToState(
    ConversationEvent event,
  ) async* {
    if (event is ConversationLoadCompleted) {
      yield ConversationListening();
    } else if (event is ConversationChangeFromIMCore) {
      yield ConversationChanged(event.v2timConversation);
    }
  }

  _receivedNewConversationFromIMCore() {
    IMCore().conversationStream.stream.listen((event) {
      add(ConversationChangeFromIMCore(event));
    });
  }
}
