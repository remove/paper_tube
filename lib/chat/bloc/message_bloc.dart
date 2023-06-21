import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';

import '../../models/friend_dao.dart';
import '../../models/get_database.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc(this.userId) : super(MessageListener()) {
    on((event, emit) async {
      if (event is MessageHistoryLoadedFromDatabase) {
        emit(MessageHistoryPushToUI(_messageList));
      } else if (event is MessageMoreHistoryLoad) {
        var historyList = await _database.myDatabase.getHistoryRecords(userId, event.limit, event.offset);
        emit(MessageMoreHistoryPushToUI(historyList));
      } else if (event is MessageUILoadedCompleted) {
        emit(MessageListener());
      } else if (event is MessageReceivedFromIMCore) {
        emit(MessageNewTextPushToUI(event.messageRecord));
      } else if (event is MessageReceivedTextFromUI) {
        _receivedNewTextFromUI(event.text);
        emit(MessageNewTextPushToUI(
          MessageRecord(
            type: 1,
            userId: userId,
            content: event.text,
            self: true,
            time: DateTime.now(),
          ),
        ));
      } else if (event is MessageReceivedImageFromUI) {
        MessageRecord messageRecord = await _receivedNewImageFromUI(event.file);
        emit(MessageNewTextPushToUI(messageRecord));
      }
    });
    _loadMessageHistoryFromDatabase();
    _imCoreMessageListener();
  }

  final String userId;
  final IMCore _imCore = IMCore();
  final GetDatabase _database = GetDatabase();
  List<MessageRecord> _messageList = [];

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
    _textMessageToDatabase(text);
    _imCore.sendMessage(text, userId);
  }

  Future<MessageRecord> _receivedNewImageFromUI(XFile file) async {
    V2TimMessage result = await _imCore.sendImageMessage(file.path, userId);
    return await _imageMessageTODatabase(file.path, result);
  }

  Future<MessageRecord> _imageMessageTODatabase(String localPath, V2TimMessage v2timMessage) async {
    int index = await _database.myDatabase.insertChatContent(
      MessageRecord(
        type: 3,
        userId: userId,
        self: true,
        content: v2timMessage.imageElem!.imageList![1]!.url as String,
        time: DateTime.now(),
      ),
    );
    await _database.myDatabase.insertMessageResource(
      MessageResource(
        index: index,
        source: localPath,
      ),
    );

    return MessageRecord(
      index: index,
      type: 3,
      userId: userId,
      self: true,
      content: v2timMessage.imageElem!.imageList![1]!.url as String,
      time: DateTime.now(),
    );
  }

  _textMessageToDatabase(String text) {
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
