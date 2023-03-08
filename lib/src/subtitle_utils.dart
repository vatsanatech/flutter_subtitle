import '../flutter_subtitle.dart';

List<Subtitle> parseFromWebVTTString(String data) {
  final List<Subtitle> subtitles = <Subtitle>[];
  final subtitleStrings = matchSubtitleStrings(data);

  int subtitleNumber = 1;

  for (final String subtitleString in subtitleStrings) {
    final subtitleLine = subtitleString.split("\n");
    final range = rangeFromWebVTTString(subtitleLine[1]);

    if (range == null) {
      continue;
    }

    subtitles.add(Subtitle(
      number: int.tryParse(subtitleLine[0]) ?? subtitleNumber,
      start: range[0].inMilliseconds,
      end: range[1].inMilliseconds,
      text: subtitleLine.skip(2).join("\n"),
    ));
    subtitleNumber++;
  }
  return subtitles;
}

//
// 00:00:00.430 --> 00:00:04.360
// Hello! I'm Nanami Mami, nineteen years old,
Iterable<String> matchSubtitleStrings(String text) => RegExp(
      _webVTTSegment,
    ).allMatches(text).map((m) => m.group(0) ?? "");

// _parseWebVTTTimestamp('00:01:08.430')
// returns
// Duration(hours: 0, minutes: 1, seconds: 8, milliseconds: 430)
Duration? parseWebVTTTimestamp(String timestampString) {
  if (!RegExp(_webVTTTimeStamp).hasMatch(timestampString)) {
    return null;
  }

  final List<String> dotSections = timestampString.split('.');
  final List<String> timeComponents = dotSections[0].split(':');

  // Validating and parsing the `timestampString`, invalid format will result this method
  // to return `null`. See https://www.w3.org/TR/webvtt1/#webvtt-timestamp for valid
  // WebVTT timestamp format.
  if (timeComponents.length > 3 || timeComponents.length < 2) {
    return null;
  }
  int hours = 0;
  if (timeComponents.length == 3) {
    final String hourString = timeComponents.removeAt(0);
    if (hourString.length < 2) {
      return null;
    }
    hours = int.parse(hourString);
  }
  final int minutes = int.parse(timeComponents.removeAt(0));
  if (minutes < 0 || minutes > 59) {
    return null;
  }
  final int seconds = int.parse(timeComponents.removeAt(0));
  if (seconds < 0 || seconds > 59) {
    return null;
  }

  final List<String> milisecondsStyles = dotSections[1].split(' ');

  final int milliseconds = int.parse(milisecondsStyles[0]);

  return Duration(
    hours: hours,
    minutes: minutes,
    seconds: seconds,
    milliseconds: milliseconds,
  );
}

// 00:09.000 --> 00:11.000
List<Duration>? rangeFromWebVTTString(String line) {
  final RegExp format =
      RegExp(_webVTTTimeStamp + _webVTTArrow + _webVTTTimeStamp);

  if (!format.hasMatch(line)) {
    return null;
  }

  final List<String> times = line.split(_webVTTArrow);

  final Duration? start = parseWebVTTTimestamp(times[0]);
  final Duration? end = parseWebVTTTimestamp(times[1]);

  if (start == null || end == null) {
    return null;
  }

  return [start, end];
}

// String extractTextFromHtml(String htmlString) {
//   return '';
// }

const String _webVTTTimeStamp = r'(\d+):(\d{2})(:\d{2})?\.(\d{3})';

const String _webVTTArrow = r' --> ';

const String _webVTTSegment =
    r'(\d+)?\n(\d{1,}:)?(\d{1,2}:)?(\d{1,2}).(\d+)\s?-->\s?(\d{1,}:)?(\d{1,2}:)?(\d{1,2}).(\d+)(.*(?:\r?(?!\r?).*)*)\n(.*(?:\r?\n(?!\r?\n).*)*)';
