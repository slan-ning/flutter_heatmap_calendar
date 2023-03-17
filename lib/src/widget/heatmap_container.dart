import 'package:flutter/material.dart';
import '../data/heatmap_color.dart';

class HeatMapContainer extends StatelessWidget {
  final DateTime date;
  final double? size;
  final double? fontSize;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? textColor;
  final EdgeInsets? margin;
  final bool? showText;
  final int? value;
  final bool? showValue;
  final bool? showTextTips;
  final Function(DateTime dateTime)? onClick;

  const HeatMapContainer({
    Key? key,
    required this.date,
    this.margin,
    this.size,
    this.fontSize,
    this.borderRadius,
    this.backgroundColor,
    this.selectedColor,
    this.textColor,
    this.onClick,
    this.showText,
    this.showTextTips,
    this.value,
    this.showValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? HeatMapColor.defaultColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutQuad,
            width: size,
            height: size,
            alignment: Alignment.center,
            child: displayText(),
            decoration: BoxDecoration(
              color: selectedColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 5)),
            ),
          ),
        ),
        onTap: () {
          onClick != null ? onClick!(date) : null;
        },
      ),
    );
  }

  displayText() {
    var text = "";
    if (showValue != null && showValue! && value != null) {
      text = value.toString();
    } else if (showText ?? false) {
      text = date.day.toString();
    }

    if (text == "") {
      return null;
    }

    if (showTextTips ?? false) {
      return Tooltip(
        message: "${date.year}-${date.month}-${date.day}:  $text",
        child: Text(
          text,
          style: TextStyle(
              color: textColor ?? const Color(0xFF8A8A8A), fontSize: fontSize),
        ),
      );
    }

    return Text(
      text,
      style: TextStyle(
          color: textColor ?? const Color(0xFF8A8A8A), fontSize: fontSize),
    );
  }
}
