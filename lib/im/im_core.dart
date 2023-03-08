import 'dart:async';

import 'package:paper_tube/friends/bloc/friends_bloc.dart';
import 'package:paper_tube/im/friend_check_type.dart';
import 'package:paper_tube/models/friend_dao.dart';
import 'package:paper_tube/models/get_database.dart';
import 'package:paper_tube/utils/generate_test_user_sig.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimConversationListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimFriendshipListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/friend_application_type_enum.dart';
import 'package:tencent_im_sdk_plugin/enum/friend_response_type_enum.dart';
import 'package:tencent_im_sdk_plugin/enum/friend_type_enum.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level_enum.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_full_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

class IMCore {
  static final IMCore _imCore = IMCore._internal();
  final V2TIMManager _manager = TencentImSDKPlugin.v2TIMManager;
  final MyDatabase _database = GetDatabase().myDatabase;
  final StreamController<V2TimMessage> messageStream =
      StreamController.broadcast();
  final StreamController<V2TimConversation> conversationStream =
      StreamController.broadcast();
  final StreamController<dynamic> addFriendStream =
      StreamController.broadcast();

  factory IMCore() {
    return _imCore;
  }

  IMCore._internal();

  init() async {
    await _manager.initSDK(
      sdkAppID: 1400413627,
      loglevel: LogLevelEnum.V2TIM_LOG_INFO,
      listener: V2TimSDKListener(),
    );
    messageListener();
    conversationListener();
    friendListener();
    await login();
  }

  login() async {
    V2TimValueCallback<int> state = await _manager.getLoginStatus();
    if (state.data == 3) {
      String userID = "aero";
      String userSig = new GenerateTestUserSig(
        sdkappid: 1400413627,
        key: "dfbd4b0ecce28bb864221e1e9e3aaf6980249da4fe7385d2a79e804fe9d69af1",
      ).genSig(
        identifier: userID,
        expire: 7 * 24 * 60 * 1000, // userSIg有效期
      );
      await _manager.login(userID: userID, userSig: userSig);
    }
  }

  Future<String?> getUserId() async {
    return (await _manager.getLoginUser()).data;
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

  ///会话列表监听
  conversationListener() {
    _manager.v2ConversationManager.setConversationListener(
        listener: V2TimConversationListener(
      onConversationChanged: (conversationList) {
        conversationStream.add(conversationList[0]);
      },
    ));
  }

  ///好友关系监听
  friendListener() {
    _manager.v2TIMFriendshipManager.setFriendListener(
      listener: V2TimFriendshipListener(
        onFriendApplicationListAdded: (applicationList) => addFriendStream
            .add(FriendsApplicationListAddFromImCore(applicationList)),
        onFriendApplicationListDeleted: (userIDList) => addFriendStream
            .add(FriendsApplicationListDeletedFromImCore(userIDList[0])),
        onFriendListAdded: (users) =>
            addFriendStream.add(FriendsListReceivedRefreshFromIMCore()),
        onFriendListDeleted: (userList) =>
            addFriendStream.add(FriendsListReceivedRefreshFromIMCore()),
      ),
    );
  }

  ///获取新好友申请列表
  Future<List<Friend>?> getNewFriendsApplicationList() async {
    var result =
        await _manager.v2TIMFriendshipManager.getFriendApplicationList();
    var applicationList = result.data?.friendApplicationList;
    applicationList?.removeWhere((element) => element?.type == 2);
    if (applicationList != null) {
      return List.of(
        result.data!.friendApplicationList!.map(
          (e) => Friend(
            userId: e?.userID,
            nickName: e?.nickname,
            avatarUrl: e?.faceUrl,
          ),
        ),
      );
    }
    return null;
  }

  ///拒绝好友申请
  rejectNewFriendApplication(String userId) {
    _manager.v2TIMFriendshipManager.refuseFriendApplication(
      type: FriendApplicationTypeEnum.V2TIM_FRIEND_APPLICATION_BOTH,
      userID: userId,
    );
  }

  ///通过好友申请
  allowNewFriendApplication(String userId) {
    _manager.v2TIMFriendshipManager.acceptFriendApplication(
      responseType: FriendResponseTypeEnum.V2TIM_FRIEND_ACCEPT_AGREE_AND_ADD,
      type: FriendApplicationTypeEnum.V2TIM_FRIEND_APPLICATION_BOTH,
      userID: userId,
    );
  }

  ///获取用户资料
  Future<V2TimUserFullInfo?> getUserInfo(String userId) async {
    return (await _manager.getUsersInfo(userIDList: [userId])).data?[0];
  }

  ///添加好友
  addFriend(String userID, String? addNote) async {
    return await _manager.v2TIMFriendshipManager.addFriend(
      addWording: addNote,
      userID: userID,
      addType: FriendTypeEnum.V2TIM_FRIEND_TYPE_BOTH,
    );
  }

  ///删除好友
  delFriend(String userId) {
    _manager.v2TIMFriendshipManager.deleteFromFriendList(
      userIDList: [userId],
      deleteType: FriendTypeEnum.V2TIM_FRIEND_TYPE_BOTH,
    );
  }

  ///发送消息给好友
  sendMessage(String text, String receiver) async {
    _manager.v2TIMMessageManager.sendTextMessage(
      text: text,
      receiver: receiver,
      groupID: "",
    );
  }

  Future<V2TimMessage> sendImageMessage(String path, String userId) async {
    var result = await _manager.v2TIMMessageManager
        .sendImageMessage(imagePath: path, receiver: userId, groupID: "");
    return result.data as V2TimMessage;
  }

  markMessageRead(String userId) async {
    _manager.v2TIMMessageManager.markC2CMessageAsRead(userID: userId);
  }

  ///好友关系检查
  Future<FriendCheckType?> friendCheck(String userId) async {
    var result = await _manager.v2TIMFriendshipManager.checkFriend(
        userIDList: [userId], checkType: FriendTypeEnum.V2TIM_FRIEND_TYPE_BOTH);
    int? resultType = result.data?[0].resultType;
    if (resultType != null) {
      return FriendCheckType.values[resultType];
    }
    return null;
  }

  ///获取好友列表
  Future<List<V2TimFriendInfo>?> getFriendList() async {
    V2TimValueCallback<List<V2TimFriendInfo>>? friends =
        await _manager.getFriendshipManager().getFriendList();
    return friends.data;
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
        .getConversationList(nextSeq: "0", count: 100)
        .then(
          (value) => conversationList = value.data?.conversationList,
        );
    return conversationList;
  }

  ///新消息写入数据库
  _newMessageToDatabase(V2TimMessage msg) async {
    String content = "未知类型消息";
    if (msg.elemType == 1) {
      content = msg.textElem?.text as String;
    } else if (msg.elemType == 3) {
      if (msg.imageElem?.imageList?[1]?.url != null) {
        content = msg.imageElem!.imageList![1]!.url as String;
      }
    }
    int index = await _database.insertChatContent(
      MessageRecord(
        type: msg.elemType,
        userId: msg.userID as String,
        content: content,
        self: false,
        time: DateTime.now(),
      ),
    );
    if (msg.elemType == 3) {
      _database.insertMessageResource(
        MessageResource(
          index: index,
          source: msg.imageElem?.imageList?[0]?.url as String,
        ),
      );
    }
  }
}
