import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paper_tube/chat/bloc/message_bloc.dart';

class InputBar extends StatelessWidget {
  const InputBar({Key? key, required this.focusNode}) : super(key: key);
  static final TextEditingController _textEditingController =
      TextEditingController();
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 390),
          curve: const Cubic(.38, 0.7, 0.125, 1),
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            border: const Border(
              top: BorderSide(
                color: Color(0x4D000000),
                width: .3,
                style: BorderStyle.solid,
              ),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom +
                MediaQuery.of(context).padding.bottom,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => showCupertinoModalPopup(
                  context: context,
                  builder: (_) => CupertinoActionSheet(
                    title: Text("来源"),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () {
                          ImagePicker()
                              .pickImage(source: ImageSource.gallery)
                              .then(
                            (value) {
                              Navigator.pop(context);
                              if (value != null) {
                                context.read<MessageBloc>().add(
                                      MessageReceivedImageFromUI(value),
                                    );
                              }
                            },
                          );
                        },
                        child: Text("图库"),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () {
                          ImagePicker()
                              .pickImage(source: ImageSource.camera)
                              .then(
                            (value) {
                              Navigator.pop(context);
                              if (value != null) {
                                context
                                    .read<MessageBloc>()
                                    .add(MessageReceivedImageFromUI(value));
                              }
                            },
                          );
                        },
                        child: Text("相机"),
                      ),
                    ],
                  ),
                ),
                child: SizedBox(
                  height: 43,
                  width: 45,
                  child: Center(
                    child: Icon(
                      CupertinoIcons.paperclip,
                      size: 24,
                      color: Color.fromRGBO(120, 131, 141, 1),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 6, bottom: 6),

                  ///TextField Height = 33
                  child: CupertinoTextField(
                    padding:
                        EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                    cursorHeight: 17,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CupertinoTheme.brightnessOf(context) ==
                              Brightness.dark
                          ? Colors.black
                          : Colors.white,
                      border: Border.all(color: Color(0x4D000000), width: .4),
                    ),
                    placeholder: "Message",
                    controller: _textEditingController,
                    focusNode: focusNode,
                    textInputAction: TextInputAction.newline,
                    maxLines: 10,
                    minLines: 1,
                  ),
                ),
              ),
              if (focusNode.hasFocus)
                GestureDetector(
                  onTap: () {
                    if (_textEditingController.text != "") {
                      BlocProvider.of<MessageBloc>(context).add(
                        MessageReceivedTextFromUI(
                          _textEditingController.text,
                        ),
                      );
                      _textEditingController.clear();
                    }
                  },
                  child: SizedBox(
                    height: 43,
                    width: 45,
                    child: Center(
                      child: Icon(
                        CupertinoIcons.arrow_up_circle_fill,
                        size: 39,
                      ),
                    ),
                  ),
                ),
              if (!focusNode.hasFocus)
                SizedBox(
                  height: 43,
                  width: 45,
                  child: Center(
                    child: Icon(
                      CupertinoIcons.mic,
                      size: 27,
                      color: Color.fromRGBO(120, 131, 141, 1),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
