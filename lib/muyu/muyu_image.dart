import 'package:flutter/material.dart';

class MuyuImage extends StatelessWidget {
  final String path;
  final VoidCallback onTap;

  const MuyuImage({super.key, required this.path, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          path,
          height: 200,
        ),
      ),
    );
  }
}
