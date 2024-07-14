import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/utils/app_colors.dart';
import 'package:flutter_food_delivary/utils/dimensions.dart';
import 'package:flutter_food_delivary/widget/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.textHeight150;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              color: AppColors.paraColor,
              title: widget.text,
              size: Dimensions.font18,
            )
          : Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SmallText(
                      height: 1.8,
                      size: Dimensions.font18,
                      color: AppColors.paraColor,
                      title: hiddenText
                          ? "$firstHalf....*****"
                          : (firstHalf + secondHalf)),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        size: Dimensions.font18,
                        title: hiddenText ? "show more" : "show less",
                        color: AppColors.mainColor,
                      ),
                      hiddenText
                          ? const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.mainColor,
                            )
                          : const Icon(
                              Icons.arrow_drop_up,
                              color: AppColors.mainColor,
                            ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
