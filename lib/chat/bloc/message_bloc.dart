import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:paper_tube/models/dao/friendDAO.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc(String userId) : super(MessageLoadDatabaseProgress(userId)) {
    _receiveNewMessage();
  }

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is MessageLoadCompleted) {
      yield MessageListening();
    } else if (event is MessageReceivedFromIMCore) {
      yield MessageReceived(event.messageRecord);
    }
  }

  _receiveNewMessage() {
    IMCore().messageStream.stream.listen((event) {
      this.add(
        MessageReceivedFromIMCore(
          MessageRecord(
            self: false,
            userId: event.userID,
            content: event.textElem?.text,
            time: DateTime.now(),
          ),
        ),
      );
    });
  }
}
