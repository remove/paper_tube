import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paper_tube/chat/view/image_detail_view.dart';
import 'package:paper_tube/models/friend_dao.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    Key? key,
    required this.messageRecord,
  }) : super(key: key);

  final MessageRecord messageRecord;
  static const ownColor = Color.fromRGBO(245, 87, 131, 1.0);
  static const otherColor = Color.fromRGBO(17, 190, 253, 1.0);

  Widget content(BuildContext context) {
    if (messageRecord.type == 1) {
      return buildTextBubble();
    } else if (messageRecord.type == 3) {
      return buildImageBubble(context);
    } else {
      return Text("未知消息类型");
    }
  }

  Container buildTextBubble() {
    return Container(
      constraints: BoxConstraints(maxWidth: 310),
      margin: const EdgeInsets.only(left: 12, bottom: 0, right: 12, top: 10),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: SelectableText(
        messageRecord.content,
        style: const TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: messageRecord.self ? ownColor : otherColor,
      ),
    );
  }

  GestureDetector buildImageBubble(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ImageDetailView(
                  url: messageRecord.content,
                  index: messageRecord.index as int,
                  self: messageRecord.self,
                ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            barrierColor: Colors.black),
      ),
      child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 12, bottom: 0, right: 12, top: 10),
            child: SizedBox(
              width: 125,
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: CachedNetworkImage(
                    imageUrl: messageRecord.content,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 220,
            width: 125,
            margin:
                const EdgeInsets.only(left: 12, bottom: 0, right: 12, top: 10),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2, color: messageRecord.self ? ownColor : otherColor),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Hero(
                tag: messageRecord.index as int,
                child: CachedNetworkImage(
                  imageUrl: messageRecord.content,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:
          messageRecord.self ? Alignment.bottomRight : Alignment.bottomLeft,
      children: [
        messageRecord.self
            ? const CustomPaint(
                painter: MinePinter(ownColor),
                size: Size(20, 15),
              )
            : const CustomPaint(
                painter: OtherPinter(otherColor),
                size: Size(20, 15),
              ),
        content(context),
      ],
    );
  }
}

class OtherPinter extends CustomPainter {
  final Color color;

  const OtherPinter(this.color);

  @override
  paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..color = color
      ..style = PaintingStyle.fill;
    final Path path = Path()
      ..moveTo(6, 15)
      ..quadraticBezierTo(12, 9, 12, 0)
      ..lineTo(20, 6)
      ..quadraticBezierTo(20, 15, 6, 15);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MinePinter extends CustomPainter {
  final Color color;

  const MinePinter(this.color);

  @override
  paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..color = color
      ..style = PaintingStyle.fill;
    final Path path = Path()
      ..moveTo(14, 15)
      ..quadraticBezierTo(8, 9, 8, 0)
      ..lineTo(0, 6)
      ..quadraticBezierTo(0, 15, 14, 15);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
