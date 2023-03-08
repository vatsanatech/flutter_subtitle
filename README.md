## Getting started

- [x] multiple line text
- [] extract html
- [] srt suporrt

![](https://i.ibb.co/BGcxskh/image.png)

```dart
import 'package:flutter_subtitle/flutter_subtitle.dart';

final subtitleController = SubtitleController.string('''WEBVTT

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

if (subtitleController != null)
  Positioned(
    bottom: 2,
    child: IgnorePointer(
      child: SubtitleControllView(
        subtitleController: subtitleController!,
        inMilliseconds: videoPlayerController.value.position.inMilliseconds,
      ),
    ),
  )

```

```dart
import 'package:flutter_subtitle/flutter_subtitle.dart' hide Subtitle;

// work with chewie
final subtitleController = SubtitleController.string('''WEBVTT

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
''');

final chewieController = ChewieController(
  videoPlayerController: videoPlayerController,
  subtitle: subtitleController!.subtitles
      .map(
        (e) => Subtitle(
          index: e.number,
          start: Duration(milliseconds: e.start),
          end: Duration(milliseconds: e.end),
          text: e.text,
        ),
      )
      .toList(),
  subtitleBuilder: (context, subtitle) {
    return SubtitleView(
      text: subtitle,
      backgroundColor: Colors.transparent,
    );
  },
);
```
