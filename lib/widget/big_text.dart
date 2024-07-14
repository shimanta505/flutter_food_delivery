import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/utils/dimensions.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final String title;
  final Color color;
  double size;
  TextOverflow overFlow;

  BigText({
    super.key,
    required this.title,
    this.color = Colors.black,
    this.size = 0,
    this.overFlow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    size = size == 0 ? Dimensions.font20 : size;
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: size,
      ),
      overflow: overFlow,
    );
  }
}
