import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Color bgColor;
  final Text text;
  final VoidCallback onTap;
  final double height, width;

  const MainButton({
    Key? key,
    required this.height,
    required this.width,
    required this.bgColor,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onTap,
        child: text,
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
