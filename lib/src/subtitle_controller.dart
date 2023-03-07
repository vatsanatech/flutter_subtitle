import 'package:flutter_subtitle/flutter_subtitle.dart';

Iterable<String> allStringMatches(String text, RegExp regExp) =>
    regExp.allMatches(text).map((m) => m.group(0) ?? "");

class SubtitleController {
  final String dataSource;

  List<Subtitle> subtitleDataList = [];

  List<String> subtitleStringList = [];

  SubtitleController.string(this.dataSource);

  void initialize() {
    subtitleStringList = _jsonToSubtitleAsListString(dataSource);
    _convertSubtitleListToSubtitleMap();
  }

  List<String> _jsonToSubtitleAsListString(String data) {
    final regex = RegExp(
      r'(\d+)?\n(\d{1,}:)?(\d{1,2}:)?(\d{1,2}).(\d+)\s?-->\s?(\d{1,}:)?(\d{1,2}:)?(\d{1,2}).(\d+)(.*(?:\r?(?!\r?).*)*)\n(.*(?:\r?\n(?!\r?\n).*)*)',
    );

    if (data != '') {
      return allStringMatches(data, regex).toList();
    }

    return [];
  }

  void _convertSubtitleListToSubtitleMap() {
    for (int subtitleIndex = 0;
        subtitleIndex < (subtitleStringList.length);
        subtitleIndex++) {
      subtitleDataList.add(
        Subtitle.fromString(
          subtitleStringList[subtitleIndex],
        ),
      );
    }
  }

  String textFromWebttvBasedOnMilliseconds(
      int currentTimeMilliseconds, List<Subtitle>? subtitleDataList) {
    Subtitle? subtitleDataModel;
    try {
      subtitleDataModel = subtitleDataList?.lastWhere(
        (data) =>
            currentTimeMilliseconds >= (data.start) &&
            currentTimeMilliseconds <= (data.end),
      );
    } catch (_) {}
    return subtitleDataModel?.text ?? "";
  }
}
