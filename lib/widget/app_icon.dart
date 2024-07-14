import 'package:flutter/cupertino.dart';
import 'package:flutter_food_delivary/utils/dimensions.dart';

// ignore: must_be_immutable
class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backGroundColor;
  final Color iconColor;
  double iconSize;
  double size;
  AppIcon({
    Key? key,
    required this.icon,
    this.backGroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.iconSize = 0,
    this.size = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = size == 0 ? Dimensions.iconContainer : size;
    iconSize = iconSize == 0 ? Dimensions.iconSize16 : iconSize;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backGroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
