import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/widget/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  const IconAndTextWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(
          width: 0,
        ),
        SmallText(
          title: title,
        ),
      ],
    );
  }
}
