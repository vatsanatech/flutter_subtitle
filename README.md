## Getting started

```dart
main() {
  final subtitleController = SubtitleController.string('''WEBVTT

0
00:02:25,603 --> 00:02:29,524
This is an example test string''')..initialize();

if (subtitleController != null)
  Positioned(
    bottom: 2,
    child: IgnorePointer(
      child: SubtitleView(
        subtitleController: subtitleController!,
        currentTimeInMilliseconds: videoPlayerController.value.position.inMilliseconds,
      ),
    ),
  ),
}
```
