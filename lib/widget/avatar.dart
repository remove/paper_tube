import 'package:flutter/cupertino.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, this.avatarUrl}) : super(key: key);

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null) {
      return Image.network(
        avatarUrl as String,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset("images/user.jpg");
    }
  }
}
