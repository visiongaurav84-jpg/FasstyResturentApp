import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;

  BlurredImage({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl ?? 'https://via.placeholder.com/150', // Replace with your no-image URL
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust sigmaX and sigmaY for blur intensity
            child: Container(
              color: Colors.black.withOpacity(0), // Transparent overlay
            ),
          ),
        ),
      ],
    );
  }
}
