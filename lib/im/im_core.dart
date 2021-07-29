import 'dart:async';

import 'package:moor/moor.dart';
import 'package:paper_tube/models/friend_dao.dart';
import 'package:paper_tube/models/get_database.dart';
import 'package:paper_tube/utils/generate_test_user_sig.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimConversationListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

class IMCore {
  static final IMCore _imCore = IMCore._internal();
  final V2TIMManager _manager = TencentImSDKPlugin.v2TIMManager;
  final MyDatabase _database = GetDatabase().myDatabase;
  late StreamController<V2TimMessage> messageStream;
  late StreamController<V2TimConversation> conversationStream;

  factory IMCore() {
    return _imCore;
  }

  IMCore._internal() {
    _manager.initSDK(
      sdkAppID: 1400413627,
      loglevel: LogLevel.V2TIM_LOG_INFO,
      listener: V2TimSDKListener(),
    );
    messageStream = StreamController.broadcast();
    conversationStream = StreamController.broadcast();
    messageListener();
    conversationListener();
    login();
  }

  login() async {
    String userID = "aero";
    String userSig = new GenerateTestUserSig(
      sdkappid: 1400413627,
      key: "dfbd4b0ecce28bb864221e1e9e3aaf6980249da4fe7385d2a79e804fe9d69af1",
    ).genSig(
      identifier: userID,
      expire: 7 * 24 * 60 * 1000, // userSIg有效期
    );
    V2TimCallback res = await _manager.login(
      userID: userID,
      userSig: userSig,
    );
    print("登陆" + res.desc);
    getFriendList();
  }

  ///消息监听
  messageListener() {
    _manager.v2TIMMessageManager.addAdvancedMsgListener(
      listener: V2TimAdvancedMsgListener(
        onRecvNewMessage: (msg) {
          ///收到新消息添加到新消息流
          if (!messageStream.isClosed) {
            messageStream.add(msg);
          }

          ///新消息写入到数据库
          _newMessageToDatabase(msg);
        },
      ),
    );
  }

  conversationListener() {
    _manager.v2ConversationManager.setConversationListener(
        listener: V2TimConversationListener(
      onConversationChanged: (conversationList) {
        conversationStream.add(conversationList[0]);
      },
    ));
  }

  ///发送消息给好友
  sendMessage(String text, String receiver) async {
    _manager.v2TIMMessageManager.sendTextMessage(
      text: text,
      receiver: receiver,
      groupID: "",
    );
  }

  ///获取好友列表
  getFriendList() async {
    V2TimValueCallback<List<V2TimFriendInfo>> friends =
        await _manager.getFriendshipManager().getFriendList();
    if (friends.data != null) {
      for (V2TimFriendInfo friendInfo
          in friends.data as List<V2TimFriendInfo>) {
        _friendsToDataBase(friendInfo);
      }
    }
  }

  ///设置好友备注
  setFriendNickName(String userId, String nickName) {
    _manager.v2TIMFriendshipManager.setFriendInfo(
      userID: userId,
      friendRemark: nickName,
    );
  }

  ///获取会话列表
  Future<List<V2TimConversation?>?> getConversationList() async {
    List<V2TimConversation?>? conversationList;
    await _manager.v2ConversationManager
        .getConversationList(
          nextSeq: "0",
          count: 100,
        )
        .then(
          (value) => conversationList = value.data?.conversationList,
        );
    return conversationList;
  }

  ///新消息写入数据库
  _newMessageToDatabase(V2TimMessage msg) {
    _database.insertChatContent(
      MessageRecord(
        userId: msg.userID,
        content: msg.textElem?.text,
        self: false,
        time: DateTime.now(),
      ),
    );
  }

  ///好友关系写入数据库
  _friendsToDataBase(V2TimFriendInfo friendInfo) {
    _database.insertFriends(
      FriendsCompanion.insert(
        logo: Value(friendInfo.userProfile?.faceUrl),
        gender: Value(friendInfo.userProfile?.gender),
        nickName: Value(friendInfo.userProfile?.nickName),
        userId: Value(friendInfo.userID),
      ),
    );
  }
}
