import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:paper_tube/models/friend_dao.dart';
import 'package:paper_tube/models/get_database.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc(this.userId) : super(MessageListener()) {
    _loadMessageHistoryFromDatabase();
    _imCoreMessageListener();
  }

  final String userId;
  final IMCore _imCore = IMCore();
  final GetDatabase _database = GetDatabase();
  List<MessageRecord> _messageList = [];

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is MessageHistoryLoadedFromDatabase) {
      yield MessageHistoryPushToUI(_messageList);
    } else if (event is MessageUILoadedCompleted) {
      yield MessageListener();
    } else if (event is MessageReceivedFromIMCore) {
      yield MessageNewTextPushToUI(event.messageRecord);
    } else if (event is MessageReceivedTextFromUI) {
      _receivedNewTextFromUI(event.text);
      yield MessageNewTextPushToUI(
        MessageRecord(
          type: 1,
          userId: userId,
          content: event.text,
          self: true,
          time: DateTime.now(),
        ),
      );
    } else if (event is MessageMoreHistoryLoad) {
      var historyList = await _database.myDatabase
          .getHistoryRecords(userId, event.limit, event.offset);
      yield MessageMoreHistoryPushToUI(historyList);
    }
  }

  _loadMessageHistoryFromDatabase() async {
    _messageList = await _database.myDatabase.getHistoryRecords(userId, 20, 0);
    add(MessageHistoryLoadedFromDatabase());
  }

  _imCoreMessageListener() {
    _imCore.messageStream.stream.listen(
      (event) {
        if (event.userID == this.userId) {
          String content = "未知类型消息";
          if (event.elemType == 1) {
            if (event.textElem?.text != null) {
              content = event.textElem!.text as String;
            }
          } else if (event.elemType == 3) {
            if (event.imageElem?.imageList?[1]?.url != null) {
              content = event.imageElem!.imageList![1]!.url as String;
              print(content);
            }
          }
          add(
            MessageReceivedFromIMCore(
              MessageRecord(
                type: event.elemType,
                self: false,
                userId: event.userID as String,
                content: content,
                time: DateTime.now(),
              ),
            ),
          );
        }
      },
    );
  }

  _receivedNewTextFromUI(String text) {
    _newMessageToDatabase(text);
    _imCore.sendMessage(text, userId);
  }

  _newMessageToDatabase(String text) {
    _database.myDatabase.insertChatContent(
      MessageRecord(
        userId: userId,
        content: text,
        self: true,
        time: DateTime.now(),
        type: 1,
      ),
    );
  }
}
