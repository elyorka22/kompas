import 'package:isar/isar.dart';
import 'package:kompas/core/constants/app_constants.dart';
import 'package:kompas/data/local/collections/collections.dart';
import 'package:path_provider/path_provider.dart';

/// Opens and owns the single Isar instance for the app process.
class IsarDatabase {
  IsarDatabase._(this.isar);

  final Isar isar;

  static Future<IsarDatabase> open() async {
    final directory = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        UserCollectionSchema,
        ConversationSessionCollectionSchema,
        ConversationMessageCollectionSchema,
        SkillCollectionSchema,
        SkillProgressCollectionSchema,
        DailyMissionCollectionSchema,
        ExpressionCollectionSchema,
        NotebookItemCollectionSchema,
        GoalCollectionSchema,
        AchievementCollectionSchema,
        UserAchievementCollectionSchema,
        UserStatisticsCollectionSchema,
        LearningPathCollectionSchema,
        UserLearningPathCollectionSchema,
        SpeechAnalysisCollectionSchema,
        AppSettingsCollectionSchema,
        ExerciseHistoryCollectionSchema,
        DailyPlanCollectionSchema,
      ],
      directory: directory.path,
      name: AppConstants.databaseName,
    );
    return IsarDatabase._(isar);
  }

  Future<void> close() => isar.close();
}
