import 'package:flutter/material.dart';
import '../util/date_util.dart';

class HeatMapMonthText extends StatelessWidget {
  /// List value of every sunday's month information.
  ///
  /// From 1: January to 12: December.
  final List<int>? firstDayInfos;

  /// The double value for space between labels.
  final double? size;

  /// The double value of font size.
  final double? fontSize;

  /// The color value of font color.
  final Color? fontColor;

  /// The margin value for correctly space between labels.
  final EdgeInsets? margin;

  const HeatMapMonthText({
    Key? key,
    this.firstDayInfos,
    this.fontSize,
    this.fontColor,
    this.size,
    this.margin,
  }) : super(key: key);

  /// The list of every month labels and fitted space.
  List<Widget> _labels() {
    List<Widget> items = [];

    // Set true if previous week was the first day of the month.
    bool _write = false;

    // Loop until check every given weeks.
    for (int label = 0; label < (firstDayInfos?.length ?? 0); label++) {
      // If given week is first week of given datesets or
      // first week of month, create labels
      if (label == 0 ||
          (label > 0 && firstDayInfos![label] != firstDayInfos![label - 1])) {
        _write = true;

        items.add(
          Container(
            width: (((size ?? 20) + (margin?.right ?? 2)) * 2),
            margin: EdgeInsets.only(
                left: margin?.left ?? 2, right: margin?.right ?? 2),
            child: Text(
              DateUtil.SHORT_MONTH_LABEL[firstDayInfos![label]],
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
              ),
            ),
          ),
        );
      } else if (_write) {
        // If given week is the next week of labeled week.
        // do nothing.
        _write = false;
      } else {
        // Else create empty box.
        items.add(Container(
          margin: EdgeInsets.only(
              left: margin?.left ?? 2, right: margin?.right ?? 2),
          width: size ?? 20,
        ));
      }
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _labels(),
    );
  }
}