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
    return CupertinoTheme(
      data: CupertinoThemeData(primaryColor: Colors.white),
      child: CupertinoPageScaffold(
        backgroundColor: const Color.fromRGBO(237, 236, 242, 1),
        navigationBar: CupertinoNavigationBar(
          brightness: Brightness.dark,
          border: null,
          previousPageTitle: "联系人",
          backgroundColor: const Color.fromRGBO(0, 0, 0, .3),
          trailing: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                  title: const Text('更多'),
                  actions: <CupertinoActionSheetAction>[
                    CupertinoActionSheetAction(
                      child: const Text(
                        '删除好友',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      '取消',
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                ),
              );
            },
            child: const SizedBox(
              height: 40,
              width: 50,
              child: Align(
                alignment: Alignment.centerRight,
                child: const Text(
                  "更多",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Avatar(avatarUrl: avatarUrl),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("备注", style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Text(
                        "我自己",
                        style: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Icon(Icons.edit, size: 15, color: Colors.black26),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("昵称", style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 2),
                  const Text("Aero"),
                  const Divider(),
                  const Text("用户名", style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 2),
                  const Text("removeneo"),
                ],
              ),
            ),
            const Spacer(),
            SafeArea(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "发消息",
                  style: TextStyle(color: Colors.cyan),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
