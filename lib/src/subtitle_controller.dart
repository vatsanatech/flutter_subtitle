import 'subtitle_model.dart';
import 'subtitle_utils.dart';

class SubtitleController {
  final String fileContents;

  List<Subtitle> get subtitles => _subtitles;

  final List<Subtitle> _subtitles;

  SubtitleController.string(this.fileContents)
      : _subtitles = parseFromWebVTTString(fileContents);

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
