import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:paper_tube/models/friend_dao.dart';
import 'package:paper_tube/models/get_database.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc(this.userId) : super(MessageLoadDatabaseProgress(userId)) {
    _receiveNewMessageFromIMCore();
  }

  final String userId;
  final IMCore _imCore = IMCore();
  final GetDatabase _database = GetDatabase();

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is MessageLoadCompleted) {
      yield MessageListening();
    } else if (event is MessageReceivedFromIMCore) {
      yield MessageReceived(event.messageRecord);
    } else if (event is MessageReceivedFromKeyBoard) {
      _receivedNewMessageFromKeyboard(event.text);
      yield MessageReceived(
        MessageRecord(
          userId: userId,
          content: event.text,
          self: true,
          time: DateTime.now(),
        ),
      );
    }
  }

  _receiveNewMessageFromIMCore() {
    _imCore.messageStream.stream.listen((event) {
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

  ///收到键盘输入发送消息
  _receivedNewMessageFromKeyboard(String text) {
    _newMessageToDatabase(text);
    _imCore.sendMessage(text, userId);
  }

  ///新消息写入数据库
  _newMessageToDatabase(String text) {
    _database.myDatabase.insertChatContent(
      MessageRecord(
        userId: userId,
        content: text,
        self: true,
        time: DateTime.now(),
      ),
    );
  }
}
