import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_tube/contact/bloc/contact_bloc.dart';

class AddFriendView extends StatefulWidget {
  const AddFriendView({Key? key}) : super(key: key);

  @override
  _AddFriendViewState createState() => _AddFriendViewState();
}

class _AddFriendViewState extends State<AddFriendView> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    print(context.read<ContactBloc>());
    ServicesBinding.instance?.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: const Color.fromRGBO(240, 239, 244, 1),
        previousPageTitle: "联系人",
        middle: const Text("添加好友"),
      ),
      child: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _focusNode.unfocus(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                color: const Color.fromRGBO(240, 239, 244, 1),
                alignment: Alignment.topLeft,
                child: CupertinoSearchTextField(
                  focusNode: _focusNode,
                  prefixInsets: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  placeholder: "用户ID",
                  backgroundColor: const Color.fromRGBO(224, 223, 230, 1),
                ),
              ),
              // Expanded(
              //   child: BlocBuilder<ContactBloc, ContactState>(
              //     builder: (context, state) {
              //       if (state is ContactResult) {
              //         print(state.v2timUserFullInfo.toJson().toString());
              //       }
              //       return ListView();
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
