import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.message, required this.own})
      : super(key: key);

  final String message;
  final bool own;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 12, bottom: 0, right: 12, top: 10),
          padding: EdgeInsets.fromLTRB(10, 2, 10, 5),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: own ? Color.fromRGBO(255, 185, 53, 1) : Colors.cyan,
          ),
        ),
        own
            ? const CustomPaint(
                painter: MinePinter(),
                size: Size(20, 15),
              )
            : const CustomPaint(
                painter: OtherPinter(),
                size: Size(20, 15),
              ),
      ],
      alignment: own ? Alignment.bottomRight : Alignment.bottomLeft,
    );
  }
}

class OtherPinter extends CustomPainter {
  const OtherPinter();

  @override
  paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..color = Colors.cyan
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
  const MinePinter();

  @override
  paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..color = Color.fromRGBO(255, 185, 53, 1)
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
