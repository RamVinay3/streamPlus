import 'package:flutter/material.dart';

class MyImageWidget extends StatelessWidget {
  final String imageUrl;

  MyImageWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Image.network(
      imageUrl,
      width: width,
      height: 250,
      fit: BoxFit.cover,
    );
  }
}
