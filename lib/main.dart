import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_tube/contact/bloc/contact_bloc.dart';
import 'package:paper_tube/contact/view/contact_view.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:paper_tube/parse/parse_core.dart';

void main() {
  runApp(MyApp());
  IMCore();
  ParseCore();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.cyan,
      ),
      home: BlocProvider(
        create: (context) => ContactBloc(),
        child: ContactView(),
      ),
    );
  }
}
