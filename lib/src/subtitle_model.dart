import 'package:flutter/foundation.dart' show objectRuntimeType;

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

  @override
  String toString() {
    return '${objectRuntimeType(this, 'Subtitle')}('
        'number: $number, '
        'start: $start, '
        'end: $end, '
        'text: $text)';
  }
}
