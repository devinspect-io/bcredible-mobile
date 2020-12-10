import 'package:flutter/material.dart';

class ImageContainerRound extends StatelessWidget {
  final double width;
  final double height;
  final Color placeholder;
  final String url;

  const ImageContainerRound({
    this.width,
    this.height,
    this.placeholder = const Color(0xFFEEEEEE),
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: Container(
        width: MediaQuery.of(context).size.width*0.1,
        height: height,
        decoration: BoxDecoration(
          color: placeholder,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(url),
          ),
        ),
      ),
    );
  }
}
