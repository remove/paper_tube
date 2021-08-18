import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewInputBar extends StatelessWidget {
  const NewInputBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoTheme.of(context).barBackgroundColor,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: CupertinoTextField(),
            ),
          ),
        ],
      ),
    );
  }
}
