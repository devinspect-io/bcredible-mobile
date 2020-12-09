import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color placeholder;
  final String url;

  const ImageContainer({
    this.width,
    this.height,
    this.placeholder = const Color(0xFFEEEEEE),
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        color: placeholder,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(url),
        ),
      ),
    );
  }
}
