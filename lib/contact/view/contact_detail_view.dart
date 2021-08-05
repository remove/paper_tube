import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper_tube/widget/avatar.dart';

class ContactDetailView extends StatelessWidget {
  const ContactDetailView({
    Key? key,
    required this.avatarUrl,
  }) : super(key: key);

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color.fromRGBO(237, 236, 242, 1),
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: "联系人",
        backgroundColor: Colors.transparent,
        trailing: Text("更多",
            style: TextStyle(color: CupertinoTheme.of(context).primaryColor)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Avatar(avatarUrl: avatarUrl),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("备注", style: TextStyle(fontSize: 15)),
                SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      "我自己",
                      style: TextStyle(
                        color: CupertinoTheme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(width: 3),
                    Icon(Icons.edit, size: 15, color: Colors.black26),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("昵称", style: TextStyle(fontSize: 15)),
                SizedBox(height: 2),
                Text("Aero"),
                Divider(),
                Text("用户名", style: TextStyle(fontSize: 15)),
                SizedBox(height: 2),
                Text("removeneo"),
              ],
            ),
          ),
          Spacer(),
          SafeArea(
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: CupertinoTheme.of(context).primaryColor,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "发消息",
                style: TextStyle(
                  color: CupertinoTheme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
