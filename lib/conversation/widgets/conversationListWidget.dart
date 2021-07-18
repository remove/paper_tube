import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper_tube/chat/view/chatPage.dart';

class ContactListWidget extends StatelessWidget {
  const ContactListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Image.network(
                "https://cdn.jsdelivr.net/gh/remove/remove@main/Avatar.jpeg"),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.of(context).push(
                  AeroPageRoute(
                    builder: (context) => ContactPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ayase",
                      style: TextStyle(
                        color: CupertinoTheme.brightnessOf(context) ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    Text(
                      "同じように笑い返していたのに,くだらねえ いつになりゃ終わる？",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            constraints:
                BoxConstraints(minWidth: 20, minHeight: 20, maxHeight: 20),
            padding: EdgeInsets.all(3),
            child: Text(
              "1",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 70, 95, 1),
              borderRadius: BorderRadius.all(Radius.circular(6)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(255, 70, 95, 0.3),
                    blurRadius: 8,
                    offset: Offset(1, 1))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AeroPageRoute extends PageRoute with CupertinoRouteTransitionMixin {
  AeroPageRoute({required this.builder, this.title});

  final WidgetBuilder builder;

  @override
  Color? get barrierColor => Color.fromRGBO(0, 0, 0, 0.13);

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  final bool maintainState = true;

  @override
  final String? title;
}
