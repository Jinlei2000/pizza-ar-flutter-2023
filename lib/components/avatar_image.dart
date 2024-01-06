import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final double size;
  final String imageUrl;

  const AvatarImage({
    Key? key,
    required this.size,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
