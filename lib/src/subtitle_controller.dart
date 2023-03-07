import 'package:flutter_subtitle/flutter_subtitle.dart';

Iterable<String> matchSegment(String text) => RegExp(
      r'(\d+)?\n(\d{1,}:)?(\d{1,2}:)?(\d{1,2}).(\d+)\s?-->\s?(\d{1,}:)?(\d{1,2}:)?(\d{1,2}).(\d+)(.*(?:\r?(?!\r?).*)*)\n(.*(?:\r?\n(?!\r?\n).*)*)',
    ).allMatches(text).map((m) => m.group(0) ?? "");

class SubtitleController {
  final String dataSource;

  List<Subtitle> subtitles = [];

  SubtitleController.string(this.dataSource);

  SubtitleController initialize() {
    subtitles = parse(dataSource);

    return this;
  }

  List<Subtitle> parse(String data) {
    final segments = matchSegment(data);
    return segments.map((segment) => Subtitle.fromString(segment)).toList();
  }

  String textFromMilliseconds(int milliseconds, List<Subtitle>? subtitls) {
    try {
      final subtitle = subtitls?.lastWhere(
        (data) => milliseconds >= (data.start) && milliseconds <= (data.end),
      );
      return subtitle?.text ?? "";
    } catch (_) {}

    return '';
  }
}
