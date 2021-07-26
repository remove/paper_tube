import 'dart:async';

import 'package:moor/moor.dart';
import 'package:paper_tube/models/friend_dao.dart';
import 'package:paper_tube/models/get_database.dart';
import 'package:paper_tube/utils/GenerateTestUserSig.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

class IMCore {
  static final IMCore _imCore = IMCore._internal();
  final V2TIMManager _manager = TencentImSDKPlugin.v2TIMManager;
  final MyDatabase _database = GetDatabase().myDatabase;
  late StreamController<V2TimMessage> messageStream;

  factory IMCore() {
    return _imCore;
  }

  IMCore._internal() {
    _manager.initSDK(
      sdkAppID: 1400413627,
      loglevel: LogLevel.V2TIM_LOG_WARN,
      listener: V2TimSDKListener(),
    );
    messageStream = StreamController.broadcast();
    messageListener();
    login();
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

  ///发送消息给好友
  sendMessage(String text, String receiver) async {
    print("IMCore发送消息");
    V2TimValueCallback<V2TimMessage> callback =
        await _manager.v2TIMMessageManager.sendTextMessage(
      text: text,
      receiver: receiver,
      groupID: "",
    );
    print("消息回调" + callback.toJson().toString());
  }

  ///获取好友
  getFriends() async {
    V2TimValueCallback<List<V2TimFriendInfo>> friends =
        await _manager.getFriendshipManager().getFriendList();
    if (friends.data != null) {
      for (V2TimFriendInfo friendInfo
          in friends.data as List<V2TimFriendInfo>) {
        _friendsToDataBase(friendInfo);
      }
    }
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
    getFriends();
  }
}
