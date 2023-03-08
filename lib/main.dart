import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_tube/conversation/view/conversation_view.dart';
import 'package:paper_tube/friends/bloc/friends_bloc.dart';
import 'package:paper_tube/friends/view/friends_view.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:paper_tube/models/get_database.dart';
import 'package:paper_tube/parse/parse_core.dart';

void main() async {
  runApp(MyApp());
  GetDatabase();
  ParseCore();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        primaryColor: Color(0xFFF55783),
      ),
      home: FutureBuilder(
        future: IMCore().init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocProvider(
              create: (context) => FriendsBloc(),
              child: HomeView(),
            );
          } else {
            return Container(
              color: CupertinoTheme.of(context).barBackgroundColor,
            );
          }
        },
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widget = [ConversationView(), FriendsView()];
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2),
          )
        ],
      ),
      tabBuilder: (context, index) => _widget[index],
    );
  }
}
