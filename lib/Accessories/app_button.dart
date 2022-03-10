import 'package:flutter/material.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';

class MainButton extends StatelessWidget {
  final Color bgColor;
  final Widget text;
  final VoidCallback onTap;
  final double height, width;
  final bool hasBorder;

  const MainButton({
    Key? key,
    required this.height,
    required this.width,
    required this.bgColor,
    required this.text,
    required this.onTap,
    this.hasBorder = false,
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
            side: (hasBorder) ? BorderSide(color: kNeutralColor) : BorderSide.none
          ),
        ),
      ),
    );
  }
}
