import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_tube/chat/bloc/aero_bloc.dart';
import 'package:paper_tube/chat/bloc/blocObserver.dart';
import 'package:paper_tube/chat/bloc/my_bloc.dart';
import 'package:paper_tube/chat/widgets/inputBar.dart';
import 'package:paper_tube/chat/widgets/message_bubble.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  GlobalKey<InputBarState> _inputKey = GlobalKey();
  double _keyBoardHeight = 40;

  @override
  void initState() {
    // Bloc.observer = BlocCat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _bottom = MediaQuery.of(context).viewInsets.bottom;
    if (_bottom != 0) {
      _keyBoardHeight = _bottom + 10;
    } else {
      _keyBoardHeight = 40;
    }
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        middle: Column(
          children: [
            Text(
              "击剑大师",
            ),
            Text(
              "在线",
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(bottom: 5, right: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              "https://cdn.jsdelivr.net/gh/remove/remove@main/huangshuyi.jpeg",
            ),
          ),
        ),
        previousPageTitle: "会话",
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _inputKey.currentState!.closeKeyBoard();
          setState(() {});
        },
        child: BlocProvider(
          create: (context) => AeroBloc(),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    MessageBubble(message: "我老婆真棒👍！！！", own: false),
                    MessageBubble(message: "我老婆真棒👍！！！", own: false),
                    MessageBubble(message: "你老婆真棒👍！！！", own: true),
                    MessageBubble(message: "我老婆真棒👍！！！", own: false),
                    MessageBubble(message: "我老婆真棒👍！！！", own: false),
                    MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          lazy: false,
                          create: (context) => MyBloc(context.read<AeroBloc>()),
                        ),
                      ],
                      child: BlocBuilder<AeroBloc, AeroState>(
                        builder: (context, state) {
                          return CupertinoSwitch(
                            value: (state as SwitchState).open,
                            onChanged: (value) {
                              context.read<AeroBloc>().add(SwitchButton());
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedPadding(
                duration: Duration(milliseconds: 350),
                curve: Curves.linearToEaseOut,
                padding: EdgeInsets.only(bottom: _keyBoardHeight),
                child: InputBar(key: _inputKey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
