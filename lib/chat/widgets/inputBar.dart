import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_tube/chat/bloc/message_bloc.dart';

class InputBar extends StatefulWidget {
  const InputBar({Key? key}) : super(key: key);

  @override
  InputBarState createState() => InputBarState();
}

enum OpenWith {
  voice,
  keyBroad,
  emoji,
}

class InputBarState extends State<InputBar> {
  final int _animationDuration = 350;
  final Curve _curve = Curves.linearToEaseOut;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  OpenWith open = OpenWith.keyBroad;
  bool lpVoice = false;
  bool tapIng = false;
  bool inputIng = false;

  void closeKeyBoard() {
    setState(() {
      inputIng = false;
    });
  }

  double _getSize(OpenWith openWith) {
    double width = MediaQuery.of(context).size.width;
    double scale = width / 6;
    if (open == openWith) {
      return 4 * scale - 10;
    } else
      return scale - 10;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              open = OpenWith.voice;
              inputIng = false;
            });
          },
          onTapDown: (details) {
            if (open == OpenWith.voice) {
              tapIng = true;
              Future.delayed(Duration(milliseconds: 150), () {
                if (tapIng) {
                  setState(() {
                    lpVoice = true;
                  });
                }
              });
            }
          },
          onTapUp: (details) {
            if (tapIng) {
              setState(() {
                lpVoice = false;
              });
            }
            tapIng = false;
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: _animationDuration),
            curve: _curve,
            width: _getSize(OpenWith.voice),
            height: lpVoice ? 100 : 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.cyan,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 180, 203, 0.5),
                  blurRadius: 10,
                )
              ],
            ),
            child: Icon(
              Icons.keyboard_voice_sharp,
              color: Colors.white,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (open == OpenWith.keyBroad) {
              setState(() {
                _focusNode.requestFocus();
                inputIng = true;
              });
            } else {
              setState(() {
                open = OpenWith.keyBroad;
              });
            }
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: _animationDuration),
            curve: _curve,
            constraints: BoxConstraints(minHeight: 50),
            width: _getSize(OpenWith.keyBroad),
            child: inputIng
                ? CupertinoTextField(
                    controller: _controller,
                    onSubmitted: (value) {
                      if (value != "") {
                        BlocProvider.of<MessageBloc>(context).add(
                          MessageReceivedFromKeyBoard(value),
                        );
                        _controller.clear();
                      }
                    },
                    keyboardType: TextInputType.text,
                    padding: EdgeInsets.fromLTRB(8, 13, 0, 12),
                    focusNode: _focusNode,
                    decoration: inputBoxDecoration(),
                    maxLines: 10,
                    minLines: 1,
                  )
                : Container(
                    decoration: inputBoxDecoration(),
                    child: Icon(
                      Icons.keyboard,
                      color: Colors.black12,
                    ),
                  ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              open = OpenWith.emoji;
              inputIng = false;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: _animationDuration),
            curve: _curve,
            width: _getSize(OpenWith.emoji),
            height: open == OpenWith.emoji ? 250 : 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(255, 185, 53, 1),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(255, 185, 53, 0.5),
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.emoji_emotions,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

BoxDecoration inputBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    border: Border.all(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      width: .5,
    ),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        blurRadius: 10,
      )
    ],
  );
}
