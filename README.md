## Getting started

```dart
import 'package:flutter_subtitle/flutter_subtitle.dart';

final subtitleController = SubtitleController.string('''WEBVTT

1
00:02:25,603 --> 00:02:29,524
This is an example test string''')..initialize();

if (subtitleController != null)
  Positioned(
    bottom: 2,
    child: IgnorePointer(
      child: SubtitleControllView(
        subtitleController: subtitleController!,
        currentTimeInMilliseconds: videoPlayerController.value.position.inMilliseconds,
      ),
    ),
  )

```

```dart
import 'package:flutter_subtitle/flutter_subtitle.dart' hide Subtitle;

final subtitleController = SubtitleController.string('''WEBVTT

1
00:02:25,603 --> 00:02:29,524
This is an example test string''')..initialize();

final chewieController = ChewieController(
  videoPlayerController: videoPlayerController,
  subtitle: subtitleController!.subtitleDataList
      .map(
        (e) => Subtitle(
          index: e.number ?? -1,
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

![](https://i.ibb.co/zNXhmS9/Screenshot-20230307-183127.jpg)
