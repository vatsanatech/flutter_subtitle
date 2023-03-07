library subtitle_view;

import 'package:flutter/material.dart';
import 'package:flutter_subtitle/flutter_subtitle.dart';
export 'package:flutter_subtitle/src/subtitle_controller.dart';

class SubtitleControllView extends StatelessWidget {
  final SubtitleController subtitleController;
  final int currentTimeInMilliseconds;

  final Color? backgroundColor;
  final SubtitleStyle subtitleStyle;
  final bool bordered;
  final EdgeInsets padding;

  const SubtitleControllView({
    Key? key,
    required this.currentTimeInMilliseconds,
    required this.subtitleController,
    this.backgroundColor = const Color.fromRGBO(0, 0, 0, 0.6),
    this.subtitleStyle = const SubtitleStyle(),
    this.bordered = true,
    this.padding = const EdgeInsets.all(4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = subtitleController.textFromWebttvBasedOnMilliseconds(
      currentTimeInMilliseconds,
      subtitleController.subtitleDataList,
    );

    if (text == '') return const SizedBox.shrink();

    return SubtitleView(
      text: text,
      padding: padding,
      bordered: bordered,
      subtitleStyle: subtitleStyle,
      backgroundColor: backgroundColor,
    );
  }
}

class SubtitleView extends StatelessWidget {
  final Color? backgroundColor;
  final SubtitleStyle subtitleStyle;
  final bool bordered;
  final EdgeInsets padding;
  final String text;

  const SubtitleView({
    Key? key,
    required this.text,
    this.backgroundColor = const Color.fromRGBO(0, 0, 0, 0.6),
    this.subtitleStyle = const SubtitleStyle(),
    this.bordered = true,
    this.padding = const EdgeInsets.all(4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding,
      color: backgroundColor,
      child: Stack(
        children: [
          if (bordered)
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: subtitleStyle.fontSize,
                color: bordered ? null : subtitleStyle.textColor,
                foreground: bordered
                    ? (Paint()
                      ..style = subtitleStyle.borderStyle.style
                      ..strokeWidth = subtitleStyle.borderStyle.strokeWidth
                      ..color = subtitleStyle.borderStyle.color)
                    : null,
              ),
            ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: subtitleStyle.fontSize,
              color: subtitleStyle.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

const _defaultStrokeWidth = 2.0;

class SubtitleBorderStyle {
  const SubtitleBorderStyle({
    this.strokeWidth = _defaultStrokeWidth,
    this.style = PaintingStyle.stroke,
    this.color = Colors.black,
  });

  final double strokeWidth;
  final PaintingStyle style;
  final Color color;
}

const _defaultFontSize = 16.0;

class SubtitleStyle {
  const SubtitleStyle({
    this.hasBorder = false,
    this.borderStyle = const SubtitleBorderStyle(),
    this.fontSize = _defaultFontSize,
    this.textColor = Colors.white,
  });
  final bool hasBorder;
  final SubtitleBorderStyle borderStyle;
  final double fontSize;
  final Color textColor;
}
