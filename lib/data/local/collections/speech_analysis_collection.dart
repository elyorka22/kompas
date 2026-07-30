import 'package:isar/isar.dart';

part 'speech_analysis_collection.g.dart';

@collection
class SpeechAnalysisCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index()
  late String userId;

  String? sessionId;
  String? messageId;
  String? audioPath;
  late int durationMs;
  late double averageAmplitude;
  late double speakingRatio;
  late int pauseCount;
  late int estimatedWords;
  late double fluencyScore;
  late double clarityScore;
  late double paceWordsPerMinute;
  late String qualityBand;
  late List<String> notes;
  late DateTime createdAt;
}
