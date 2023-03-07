import 'package:flutter/foundation.dart' show objectRuntimeType;
import 'package:flutter_subtitle/src/subtitle_utils.dart';

class Subtitle {
  final int? number;
  final int start;
  final int end;
  final String text;

  const Subtitle({
    required this.number,
    required this.start,
    required this.end,
    required this.text,
  });

  factory Subtitle.fromString(String webVttString) {
    return Subtitle(
      start: returnsMinimumTime(webVttString),
      end: returnsMaximumTime(webVttString),
      number: int.tryParse(webVttString.split("\n")[0]),
      text: webVttString.split("\n").skip(2).join("\n"),
    );
  }
  static const Subtitle none = Subtitle(
    number: 0,
    start: -1,
    end: -1,
    text: '',
  );

  @override
  String toString() {
    return '${objectRuntimeType(this, 'Subtitle')}('
        'number: $number, '
        'start: $start, '
        'end: $end, '
        'text: $text)';
  }
}
