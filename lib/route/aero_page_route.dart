import 'package:flutter/cupertino.dart';

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
