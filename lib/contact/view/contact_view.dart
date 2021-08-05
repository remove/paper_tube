import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:paper_tube/contact/bloc/contact_bloc.dart';
import 'package:paper_tube/contact/view/contact_detail_view.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:paper_tube/route/aero_page_route.dart';
import 'package:paper_tube/widget/avatar.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info.dart';

class ContactView extends StatefulWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  List<ContactListData> _friends = [];
  List<String> _tagList = [];

  _getContactList(BuildContext context) {
    IMCore().getFriendList().then(
      (value) {
        if (value != null) {
          for (V2TimFriendInfo friend in value) {
            _friends.add(
              ContactListData(
                friendRemark: friend.friendRemark,
                avatarUrl: friend.userProfile?.faceUrl,
                userID: friend.userID,
              ),
            );
          }
          SuspensionUtil.sortListBySuspensionTag(_friends);
          SuspensionUtil.setShowSuspensionStatus(_friends);
          _tagList = SuspensionUtil.getTagIndexList(_friends);
        }
        context.read<ContactBloc>().add(ContactLoadCompleted());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("联系人"),
      ),
      child: SafeArea(
        child: BlocProvider(
          create: (context) => ContactBloc(),
          child: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              if (state is ContactInitial) {
                _getContactList(context);
              }
              return AzListView(
                susItemHeight: 30,
                susItemBuilder: (context, index) {
                  return buildSusItem(context, index);
                },
                physics: AlwaysScrollableScrollPhysics(),
                indexBarData: _tagList,
                data: _friends,
                itemCount: _friends.length,
                itemBuilder: (context, index) {
                  return buildContact(index);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildContact(int index) {
    ContactListData contact = _friends[index];
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        AeroPageRoute(
          builder: (context) => ContactDetailView(avatarUrl: contact.avatarUrl),
        ),
      ),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Avatar(avatarUrl: contact.avatarUrl),
              ),
            ),
            Text(
              contact.friendRemark ?? contact.userID,
            ),
          ],
        ),
      ),
    );
  }

  Container buildSusItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(left: 14),
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      height: 30,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          _friends[index].getSuspensionTag(),
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}

class ContactListData extends ISuspensionBean {
  String? friendRemark;
  String? avatarUrl;
  String userID;

  ContactListData({
    required this.friendRemark,
    required this.avatarUrl,
    required this.userID,
  });

  String transChineseToPinYin() {
    if (ChineseHelper.isChinese(friendRemark ?? "")) {
      return PinyinHelper.getFirstWordPinyin(friendRemark as String);
    } else {
      return friendRemark ?? userID;
    }
  }

  @override
  String getSuspensionTag() =>
      transChineseToPinYin().substring(0, 1).toUpperCase();
}
