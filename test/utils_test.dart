// ignore_for_file: constant_identifier_names, avoid_print, unused_import, unused_element

import 'package:flutter_subtitle/flutter_subtitle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test utils', () {
    // final lineSections = readSubtitleFile(_valid_vtt_with_metadata);
    // final regSections = matchSubtitleStrings(_valid_vtt_with_metadata);

    // print(lineSections);
    // print(regSections);
  });
}

const String _malformedSubRip = '''
1
00:00:06,000--> 00:00:12,074
This one should be ignored because the
arrow needs a space.

2
00:00:15,000 --> 00:00:17,074
This one is valid

3
00:01:54,724 --> 00:01:6,760
This one should be ignored because the
ned time is missing a digit.
''';

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
