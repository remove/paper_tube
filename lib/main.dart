import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper_tube/conversation/view/conversation_view.dart';
import 'package:paper_tube/im/im_core.dart';

void main() {
  runApp(MyApp());
  IMCore();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.cyan,
      ),
      home: ConversationView(),
    );
  }
}
