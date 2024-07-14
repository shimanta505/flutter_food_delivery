import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  final String title;
  final Color color;
  double size;
  double height;

  SmallText({
    super.key,
    required this.title,
    this.color = const Color(0xFFccc7c5),
    this.size = 0,
    this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: size == 0 ? Dimensions.font14 : size,
        height: height,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
