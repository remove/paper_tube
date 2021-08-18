import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:paper_tube/models/get_database.dart';
import 'package:photo_view/photo_view.dart';

class ImageDetailView extends StatelessWidget {
  ImageDetailView({
    Key? key,
    required this.index,
    required this.url,
  }) : super(key: key);
  final String url;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: index,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.contain,
            ),
          ),
          FutureBuilder<String>(
            future: _getResource(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return PhotoView(
                  imageProvider:
                      CachedNetworkImageProvider(snapshot.data as String),
                  maxScale: PhotoViewComputedScale.covered,
                  minScale: PhotoViewComputedScale.contained,
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<String> _getResource() async {
    String url =
        (await GetDatabase().myDatabase.getMessageResource(index))[0].source;
    await Future.delayed(Duration(milliseconds: 500));
    return url;
  }
}
