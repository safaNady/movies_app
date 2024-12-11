import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieImageWithAddButton extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onAddPressed;
  final double imageWidth;
  final double imageHeight;

  const MovieImageWithAddButton({
    Key? key,
    required this.imageUrl,
    required this.onAddPressed,
    required this.imageWidth,
    required this.imageHeight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Movie Poster
        Image.network(
          imageUrl,
          width:imageWidth,
          height: imageHeight,
          fit: BoxFit.cover,
        ),
        // Add Icon at top-left corner
        Positioned(
          top: 4.w,
          left: 4.w,
          child: GestureDetector(
            onTap: onAddPressed,
            child: Container(
              width: 24.w,
              height: 24.w,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
