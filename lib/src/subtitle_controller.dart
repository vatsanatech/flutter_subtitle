import 'subtitle_model.dart';
import 'subtitle_utils.dart';

class SubtitleController {
  final String fileContents;

  final SubtitleFormat format;

  List<Subtitle> get subtitles => _subtitles;

  final List<Subtitle> _subtitles;

  bool get isEmpty => subtitles.isEmpty;

  bool get isNotEmpty => !isEmpty;

  SubtitleController.string(this.fileContents, {required this.format})
      : _subtitles = parseSubtitleString(fileContents, format);

  String textFromMilliseconds(int milliseconds, List<Subtitle> subtitls) {
    final subtitle = subtitls.lastWhere(
      (data) => milliseconds >= (data.start) && milliseconds <= (data.end),
      orElse: () => Subtitle.empty,
    );
    return subtitle.text;
  }
}
