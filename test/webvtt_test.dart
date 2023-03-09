// ignore_for_file: constant_identifier_names

import 'package:flutter_subtitle/flutter_subtitle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Parse VTT file', () {
    SubtitleController parsedFile;

    test('with Metadata', () {
      parsedFile = SubtitleController.string(
        _valid_vtt_with_metadata,
        format: SubtitleFormat.webvtt,
      );
      expect(parsedFile.subtitles.length, 1);

      expect(parsedFile.subtitles[0].start,
          const Duration(seconds: 1).inMilliseconds);
      expect(parsedFile.subtitles[0].end,
          const Duration(seconds: 2, milliseconds: 500).inMilliseconds);
      expect(parsedFile.subtitles[0].text, 'We are in New York City');
    });

    test('with Multiline', () {
      parsedFile = SubtitleController.string(
        _valid_vtt_with_multiline,
        format: SubtitleFormat.webvtt,
      );
      expect(parsedFile.subtitles.length, 1);

      expect(parsedFile.subtitles[0].start,
          const Duration(seconds: 2, milliseconds: 800).inMilliseconds);
      expect(parsedFile.subtitles[0].end,
          const Duration(seconds: 3, milliseconds: 283).inMilliseconds);
      expect(parsedFile.subtitles[0].text,
          '— It will perforate your stomach.\n— You could die.');
    });

    test('with styles tags', () {
      parsedFile = SubtitleController.string(
        _valid_vtt_with_styles,
        format: SubtitleFormat.webvtt,
      );
      expect(parsedFile.subtitles.length, 3);

      expect(parsedFile.subtitles[0].start,
          const Duration(seconds: 5, milliseconds: 200).inMilliseconds);
      expect(parsedFile.subtitles[0].end,
          const Duration(seconds: 6).inMilliseconds);
      expect(parsedFile.subtitles[0].text,
          "You know I'm so excited my glasses are falling off here.");
    });

    test('with subtitling features', () {
      parsedFile = SubtitleController.string(
        _valid_vtt_with_subtitling_features,
        format: SubtitleFormat.webvtt,
      );
      expect(parsedFile.subtitles.length, 3);

      expect(parsedFile.subtitles[0].number, 1);
      expect(parsedFile.subtitles.last.start,
          const Duration(seconds: 4).inMilliseconds);
      expect(parsedFile.subtitles.last.end,
          const Duration(seconds: 5).inMilliseconds);
      expect(parsedFile.subtitles.last.text, 'Transcrit par Célestes™');
    });

    test('with [hours]:[minutes]:[seconds].[milliseconds].', () {
      parsedFile = SubtitleController.string(
        _valid_vtt_with_hours,
        format: SubtitleFormat.webvtt,
      );
      expect(parsedFile.subtitles.length, 1);

      expect(parsedFile.subtitles[0].number, 1);
      expect(parsedFile.subtitles.last.start,
          const Duration(seconds: 1).inMilliseconds);
      expect(parsedFile.subtitles.last.end,
          const Duration(seconds: 2).inMilliseconds);
      expect(parsedFile.subtitles.last.text, 'This is a test.');
    });

    test('with [minutes]:[seconds].[milliseconds].', () {
      parsedFile = SubtitleController.string(
        _valid_vtt_without_hours,
        format: SubtitleFormat.webvtt,
      );
      expect(parsedFile.subtitles.length, 1);

      expect(parsedFile.subtitles[0].number, 1);
      expect(parsedFile.subtitles.last.start,
          const Duration(seconds: 3).inMilliseconds);
      expect(parsedFile.subtitles.last.end,
          const Duration(seconds: 4).inMilliseconds);
      expect(parsedFile.subtitles.last.text, 'This is a test.');
    });

    test('with invalid seconds format returns empty subtitles.', () {
      parsedFile = SubtitleController.string(
        _invalid_seconds,
        format: SubtitleFormat.webvtt,
      );
      expect(parsedFile.subtitles, isEmpty);
    });

    test('with invalid minutes format returns empty subtitles.', () {
      parsedFile = SubtitleController.string(
        _invalid_minutes,
        format: SubtitleFormat.webvtt,
      );
      expect(parsedFile.subtitles, isEmpty);
    });

    test('with invalid hours format returns empty subtitles.', () {
      parsedFile = SubtitleController.string(
        _invalid_hours,
        format: SubtitleFormat.webvtt,
      );
      expect(parsedFile.subtitles, isEmpty);
    });

    test('with invalid component length returns empty subtitles.', () {
      parsedFile = SubtitleController.string(
        _time_component_too_long,
        format: SubtitleFormat.webvtt,
      );
      expect(parsedFile.subtitles, isEmpty);

      parsedFile = SubtitleController.string(
        _time_component_too_short,
        format: SubtitleFormat.webvtt,
      );
      expect(parsedFile.subtitles, isEmpty);
    });
  });

  test('Parses VTT file with malformed input.', () {
    final SubtitleController parsedFile = SubtitleController.string(
      _malformedVTT,
      format: SubtitleFormat.webvtt,
    );

    expect(parsedFile.subtitles.length, 1);

    final Subtitle firstCaption = parsedFile.subtitles.single;
    expect(firstCaption.number, 1);
    expect(firstCaption.start, const Duration(seconds: 13).inMilliseconds);
    expect(firstCaption.end, const Duration(seconds: 16).inMilliseconds);
    expect(firstCaption.text, 'Valid');
  });
}

/// See https://www.w3.org/TR/webvtt1/#introduction-comments
const String _valid_vtt_with_metadata = '''
WEBVTT Kind: subtitles; Language: en

REGION
id:bill
width:40%
lines:3
regionanchor:100%,100%
viewportanchor:90%,90%
scroll:up

NOTE
This file was written by Jill. I hope
you enjoy reading it. Some things to
bear in mind:
- I was lip-reading, so the cues may
not be 100% accurate
- I didn’t pay too close attention to
when the cues should start or end.

1
00:01.000 --> 00:02.500
<v Roger Bingham>We are in New York City''';

/// See https://www.w3.org/TR/webvtt1/#introduction-multiple-lines
const String _valid_vtt_with_multiline = '''
WEBVTT

2
00:02.800 --> 00:03.283
— It will perforate your stomach.
— You could die.

''';

/// See https://www.w3.org/TR/webvtt1/#styling
const String _valid_vtt_with_styles = '''
WEBVTT

00:05.200 --> 00:06.000 align:start size:50%
<v Roger Bingham><i>You know I'm so excited my glasses are falling off here.</i>

00:00:06.050 --> 00:00:06.150
<v Roger Bingham><i>I have a different time!</i>

00:06.200 --> 00:06.900
<c.yellow.bg_blue>This is yellow text on a blue background</c>

''';

//See https://www.w3.org/TR/webvtt1/#introduction-other-features
const String _valid_vtt_with_subtitling_features = '''
WEBVTT

test
00:00.000 --> 00:02.000
This is a test.

Slide 1
00:00:00.000 --> 00:00:10.700
Title Slide

crédit de transcription
00:04.000 --> 00:05.000
Transcrit par Célestes™

''';

/// With format [hours]:[minutes]:[seconds].[milliseconds]
const String _valid_vtt_with_hours = '''
WEBVTT

test
00:00:01.000 --> 00:00:02.000
This is a test.

''';

/// Invalid seconds format.
const String _invalid_seconds = '''
WEBVTT

60:00:000.000 --> 60:02:000.000
This is a test.

''';

/// Invalid minutes format.
const String _invalid_minutes = '''
WEBVTT

60:60:00.000 --> 60:70:00.000
This is a test.

''';

/// Invalid hours format.
const String _invalid_hours = '''
WEBVTT

5:00:00.000 --> 5:02:00.000
This is a test.

''';

/// Invalid seconds format.
const String _time_component_too_long = '''
WEBVTT

60:00:00:00.000 --> 60:02:00:00.000
This is a test.

''';

/// Invalid seconds format.
const String _time_component_too_short = '''
WEBVTT

60:00.000 --> 60:02.000
This is a test.

''';

/// With format [minutes]:[seconds].[milliseconds]
const String _valid_vtt_without_hours = '''
WEBVTT

00:03.000 --> 00:04.000
This is a test.

''';

const String _malformedVTT = '''

WEBVTT Kind: subtitles; Language: en

00:09.000--> 00:11.430
<Test>This one should be ignored because the arrow needs a space.

00:13.000 --> 00:16.000
<Test>Valid

00:16.000 --> 00:8.000
<Test>This one should be ignored because the time is missing a digit.

''';
