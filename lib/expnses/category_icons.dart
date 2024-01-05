import 'package:Expenso/expnses/expense.dart';
import 'package:flutter/material.dart';

class CategoryIcon extends StatefulWidget {
  final CategoryIconData categoryIconData;

  final Function? onTap;

  const CategoryIcon({
    required this.categoryIconData,
    this.onTap,
    super.key,
  });

  @override
  State<CategoryIcon> createState() => _CategoryIconState();
}

class _CategoryIconState extends State<CategoryIcon> {
  late int? backgroundColorValue = widget.categoryIconData.backgroundColorValue;
  late Color? backgroundColor =
      backgroundColorValue == null ? null : Color(backgroundColorValue!);

  late int? colorValue = widget.categoryIconData.colorValue;
  late Color? color = colorValue == null ? null : Color(colorValue!);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        widget.onTap?.call();
      }),
      child: Container(
        color: backgroundColor,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                IconData(widget.categoryIconData.iconDataCodepoint!,
                    fontFamily: 'MaterialIcons'),
                color: color,
              ),
              Text(
                widget.categoryIconData.label!,
                textScaleFactor: 0.7,
                textAlign: TextAlign.center,
                style: TextStyle(),
              ), // Todo: Use a condensed font/ make font condensed
            ]),
      ),
    );
  }
}
