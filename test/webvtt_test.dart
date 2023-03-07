import 'package:flutter_subtitle/flutter_subtitle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final webvttController = SubtitleController.string('''WEBVTT

00:00:00.430 --> 00:00:04.360
Hello! I'm Nanami Mami, nineteen years old,

00:00:04.360 --> 00:00:07.100
and I'm a college student living
with my family in Tokyo.

00:00:07.100 --> 00:00:10.640
Kazu-kun and I dated for about a month.

00:00:07.980 --> 00:00:09.190
<b>Let's break up, okay?</b>

00:00:09.530 --> 00:00:10.570
<b>What?</b>
''')..initialize();

  getVttText(int seconds) {
    return webvttController.textFromMilliseconds(
      Duration(seconds: seconds).inMilliseconds,
      webvttController.subtitles,
    );
  }

  test('webvtt', () {
    //https://cc.zorores.com/20/2e/202eaab6dff289a5976399077449654e/eng-2.vtt
    expect(getVttText(1), '''Hello! I'm Nanami Mami, nineteen years old,''');
    expect(getVttText(8), '''<b>Let's break up, okay?</b>''');
    expect(getVttText(99), '');
  });
}
