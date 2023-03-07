import 'package:flutter/foundation.dart' show objectRuntimeType;
import 'package:flutter_subtitle/src/subtitle_utils.dart';

class Subtitle {
  final int number;
  final int start;
  final int end;
  final String text;

  const Subtitle({
    required this.number,
    required this.start,
    required this.end,
    required this.text,
  });

  factory Subtitle.fromString(String segment) {
    final rang = matchTimeRange(segment);
    return Subtitle(
      start: rang[0],
      end: rang[1],
      text: segment.split("\n").skip(2).join("\n"),
      number: int.tryParse(segment.split("\n")[0]) ?? 0,
    );
  }

  @override
  String toString() {
    return '${objectRuntimeType(this, 'Subtitle')}('
        'number: $number, '
        'start: $start, '
        'end: $end, '
        'text: $text)';
  }
}
