import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper_tube/conversation/widgets/conversationListWidget.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
