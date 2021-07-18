import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper_tube/conversation/widgets/conversationListWidget.dart';
import 'package:paper_tube/utils/GenerateTestUserSig.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

import 'models/dao/friendDAO.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.cyan,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static V2TIMManager manager = TencentImSDKPlugin.v2TIMManager;
  List<String?> _messageList = [];
  MyDatabase myDatabase = MyDatabase();

  @override
  void initState() {
    manager.initSDK(
      sdkAppID: 1400413627,
      loglevel: LogLevel.V2TIM_LOG_WARN,
      listener: V2TimSDKListener(),
    );
    addListener();
    super.initState();
  }

  addListener() async {
    manager.getMessageManager().addAdvancedMsgListener(
      listener: V2TimAdvancedMsgListener(
        onRecvNewMessage: (msg) {
          _messageList.add(msg.textElem?.text);
          setState(() {});
        },
      ),
    );
  }

  login() async {
    String userID = "aero";
    // 正式环境请在服务端计算userSIg
    String userSig = new GenerateTestUserSig(
      sdkappid: 1400413627,
      key: "dfbd4b0ecce28bb864221e1e9e3aaf6980249da4fe7385d2a79e804fe9d69af1",
    ).genSig(
      identifier: userID,
      expire: 7 * 24 * 60 * 1000, // userSIg有效期
    );
    V2TimCallback res = await manager.login(
      userID: userID,
      userSig: userSig,
    );
    print("登陆" + res.desc);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            stretch: true,
            largeTitle: Text("会话"),
          ),
          SliverFixedExtentList(
            itemExtent: 70,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index <= 0) {
                  return ContactListWidget();
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }
}
