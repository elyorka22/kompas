import 'package:isar/isar.dart';
import 'package:kompas/data/local/collections/collections.dart';
import 'package:kompas/domain/entities/entities.dart';
import 'package:kompas/domain/enums/enums.dart';

/// Maps between pure domain entities and Isar collections.
///
/// Domain never imports Isar. Collections never leave the data layer.
abstract final class EntityMappers {
  // ── User ──────────────────────────────────────────────────────────────

  static User toUser(UserCollection c) => User(
        id: c.domainId,
        displayName: c.displayName,
        nativeLanguage: AppLanguage.fromCode(c.nativeLanguageCode),
        targetLanguage: AppLanguage.fromCode(c.targetLanguageCode),
        onboardingCompleted: c.onboardingCompleted,
        dailySpeakingGoalMinutes: c.dailySpeakingGoalMinutes,
        learningGoal: c.learningGoal,
        avatarSeed: c.avatarSeed,
        createdAt: c.createdAt,
        updatedAt: c.updatedAt,
      );

  static UserCollection fromUser(User e, {int? isarId}) {
    return UserCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..displayName = e.displayName
      ..nativeLanguageCode = e.nativeLanguage.code
      ..targetLanguageCode = e.targetLanguage.code
      ..onboardingCompleted = e.onboardingCompleted
      ..dailySpeakingGoalMinutes = e.dailySpeakingGoalMinutes
      ..learningGoal = e.learningGoal
      ..avatarSeed = e.avatarSeed
      ..createdAt = e.createdAt
      ..updatedAt = e.updatedAt;
  }

  // ── ConversationSession ───────────────────────────────────────────────

  static ConversationSession toSession(ConversationSessionCollection c) =>
      ConversationSession(
        id: c.domainId,
        userId: c.userId,
        mode: PracticeMode.values.byName(c.mode),
        status: SessionStatus.values.byName(c.status),
        title: c.title,
        prompt: c.prompt,
        targetSkillId: c.targetSkillId,
        currentExerciseId: c.currentExerciseId,
        startedAt: c.startedAt,
        endedAt: c.endedAt,
        speakingSeconds: c.speakingSeconds,
        messageCount: c.messageCount,
        exercisesCompleted: c.exercisesCompleted,
        createdAt: c.createdAt,
        updatedAt: c.updatedAt,
      );

  static ConversationSessionCollection fromSession(
    ConversationSession e, {
    int? isarId,
  }) {
    return ConversationSessionCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..mode = e.mode.name
      ..status = e.status.name
      ..title = e.title
      ..prompt = e.prompt
      ..targetSkillId = e.targetSkillId
      ..currentExerciseId = e.currentExerciseId
      ..startedAt = e.startedAt
      ..endedAt = e.endedAt
      ..speakingSeconds = e.speakingSeconds
      ..messageCount = e.messageCount
      ..exercisesCompleted = e.exercisesCompleted
      ..createdAt = e.createdAt
      ..updatedAt = e.updatedAt;
  }

  // ── ConversationMessage ───────────────────────────────────────────────

  static ConversationMessage toMessage(ConversationMessageCollection c) =>
      ConversationMessage(
        id: c.domainId,
        sessionId: c.sessionId,
        role: MessageRole.values.byName(c.role),
        content: c.content,
        audioPath: c.audioPath,
        durationMs: c.durationMs,
        speechAnalysisId: c.speechAnalysisId,
        createdAt: c.createdAt,
      );

  static ConversationMessageCollection fromMessage(
    ConversationMessage e, {
    int? isarId,
  }) {
    return ConversationMessageCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..sessionId = e.sessionId
      ..role = e.role.name
      ..content = e.content
      ..audioPath = e.audioPath
      ..durationMs = e.durationMs
      ..speechAnalysisId = e.speechAnalysisId
      ..createdAt = e.createdAt;
  }

  // ── Skill ─────────────────────────────────────────────────────────────

  static Skill toSkill(SkillCollection c) => Skill(
        id: c.domainId,
        code: c.code,
        title: c.title,
        description: c.description,
        category: SkillCategory.values.byName(c.category),
        order: c.order,
        prerequisiteSkillIds: List<String>.from(c.prerequisiteSkillIds),
        xpToMaster: c.xpToMaster,
        isFuture: c.isFuture,
      );

  static SkillCollection fromSkill(Skill e, {int? isarId}) {
    return SkillCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..code = e.code
      ..title = e.title
      ..description = e.description
      ..category = e.category.name
      ..order = e.order
      ..prerequisiteSkillIds = List<String>.from(e.prerequisiteSkillIds)
      ..xpToMaster = e.xpToMaster
      ..isFuture = e.isFuture;
  }

  // ── SkillProgress ─────────────────────────────────────────────────────

  static SkillProgress toSkillProgress(SkillProgressCollection c) =>
      SkillProgress(
        id: c.domainId,
        userId: c.userId,
        skillId: c.skillId,
        status: SkillStatus.values.byName(c.status),
        xp: c.xp,
        masteredAt: c.masteredAt,
        updatedAt: c.updatedAt,
      );

  static SkillProgressCollection fromSkillProgress(
    SkillProgress e, {
    int? isarId,
  }) {
    return SkillProgressCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..skillId = e.skillId
      ..status = e.status.name
      ..xp = e.xp
      ..masteredAt = e.masteredAt
      ..updatedAt = e.updatedAt;
  }

  // ── DailyMission ──────────────────────────────────────────────────────

  static DailyMission toMission(DailyMissionCollection c) => DailyMission(
        id: c.domainId,
        userId: c.userId,
        type: MissionType.values.byName(c.type),
        status: MissionStatus.values.byName(c.status),
        title: c.title,
        description: c.description,
        targetValue: c.targetValue,
        currentValue: c.currentValue,
        skillId: c.skillId,
        dayKey: c.dayKey,
        completedAt: c.completedAt,
        createdAt: c.createdAt,
        updatedAt: c.updatedAt,
      );

  static DailyMissionCollection fromMission(DailyMission e, {int? isarId}) {
    return DailyMissionCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..type = e.type.name
      ..status = e.status.name
      ..title = e.title
      ..description = e.description
      ..targetValue = e.targetValue
      ..currentValue = e.currentValue
      ..skillId = e.skillId
      ..dayKey = e.dayKey
      ..completedAt = e.completedAt
      ..createdAt = e.createdAt
      ..updatedAt = e.updatedAt;
  }

  // ── Expression ────────────────────────────────────────────────────────

  static Expression toExpression(ExpressionCollection c) => Expression(
        id: c.domainId,
        userId: c.userId,
        targetText: c.targetText,
        nativeText: c.nativeText,
        phonetic: c.phonetic,
        contextExample: c.contextExample,
        tags: List<String>.from(c.tags),
        source: ExpressionSource.values.byName(c.source),
        strength: MemoryStrength.values.byName(c.strength),
        easeFactor: c.easeFactor,
        intervalDays: c.intervalDays,
        repetitions: c.repetitions,
        nextReviewAt: c.nextReviewAt,
        lastReviewedAt: c.lastReviewedAt,
        createdAt: c.createdAt,
        updatedAt: c.updatedAt,
      );

  static ExpressionCollection fromExpression(Expression e, {int? isarId}) {
    return ExpressionCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..targetText = e.targetText
      ..nativeText = e.nativeText
      ..phonetic = e.phonetic
      ..contextExample = e.contextExample
      ..tags = List<String>.from(e.tags)
      ..source = e.source.name
      ..strength = e.strength.name
      ..easeFactor = e.easeFactor
      ..intervalDays = e.intervalDays
      ..repetitions = e.repetitions
      ..nextReviewAt = e.nextReviewAt
      ..lastReviewedAt = e.lastReviewedAt
      ..createdAt = e.createdAt
      ..updatedAt = e.updatedAt;
  }

  // ── NotebookItem ──────────────────────────────────────────────────────

  static NotebookItem toNotebookItem(NotebookItemCollection c) => NotebookItem(
        id: c.domainId,
        userId: c.userId,
        type: NotebookItemType.values.byName(c.type),
        title: c.title,
        body: c.body,
        expressionId: c.expressionId,
        sessionId: c.sessionId,
        tags: List<String>.from(c.tags),
        isPinned: c.isPinned,
        createdAt: c.createdAt,
        updatedAt: c.updatedAt,
      );

  static NotebookItemCollection fromNotebookItem(
    NotebookItem e, {
    int? isarId,
  }) {
    return NotebookItemCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..type = e.type.name
      ..title = e.title
      ..body = e.body
      ..expressionId = e.expressionId
      ..sessionId = e.sessionId
      ..tags = List<String>.from(e.tags)
      ..isPinned = e.isPinned
      ..createdAt = e.createdAt
      ..updatedAt = e.updatedAt;
  }

  // ── Goal ──────────────────────────────────────────────────────────────

  static Goal toGoal(GoalCollection c) => Goal(
        id: c.domainId,
        userId: c.userId,
        title: c.title,
        period: GoalPeriod.values.byName(c.period),
        status: GoalStatus.values.byName(c.status),
        targetValue: c.targetValue,
        currentValue: c.currentValue,
        unit: c.unit,
        startsAt: c.startsAt,
        endsAt: c.endsAt,
        createdAt: c.createdAt,
        updatedAt: c.updatedAt,
      );

  static GoalCollection fromGoal(Goal e, {int? isarId}) {
    return GoalCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..title = e.title
      ..period = e.period.name
      ..status = e.status.name
      ..targetValue = e.targetValue
      ..currentValue = e.currentValue
      ..unit = e.unit
      ..startsAt = e.startsAt
      ..endsAt = e.endsAt
      ..createdAt = e.createdAt
      ..updatedAt = e.updatedAt;
  }

  // ── Achievement ───────────────────────────────────────────────────────

  static Achievement toAchievement(AchievementCollection c) => Achievement(
        id: c.domainId,
        code: c.code,
        title: c.title,
        description: c.description,
        category: AchievementCategory.values.byName(c.category),
        tier: AchievementTier.values.byName(c.tier),
        targetValue: c.targetValue,
      );

  static AchievementCollection fromAchievement(Achievement e, {int? isarId}) {
    return AchievementCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..code = e.code
      ..title = e.title
      ..description = e.description
      ..category = e.category.name
      ..tier = e.tier.name
      ..targetValue = e.targetValue;
  }

  static UserAchievement toUserAchievement(UserAchievementCollection c) =>
      UserAchievement(
        id: c.domainId,
        userId: c.userId,
        achievementId: c.achievementId,
        progress: c.progress,
        unlockedAt: c.unlockedAt,
        updatedAt: c.updatedAt,
      );

  static UserAchievementCollection fromUserAchievement(
    UserAchievement e, {
    int? isarId,
  }) {
    return UserAchievementCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..achievementId = e.achievementId
      ..progress = e.progress
      ..unlockedAt = e.unlockedAt
      ..updatedAt = e.updatedAt;
  }

  // ── Statistics ────────────────────────────────────────────────────────

  static UserStatistics toStatistics(UserStatisticsCollection c) =>
      UserStatistics(
        id: c.domainId,
        userId: c.userId,
        totalSpeakingSeconds: c.totalSpeakingSeconds,
        totalSessions: c.totalSessions,
        completedSessions: c.completedSessions,
        expressionsSaved: c.expressionsSaved,
        expressionsMastered: c.expressionsMastered,
        missionsCompleted: c.missionsCompleted,
        currentStreakDays: c.currentStreakDays,
        longestStreakDays: c.longestStreakDays,
        skillsMastered: c.skillsMastered,
        achievementsUnlocked: c.achievementsUnlocked,
        lastPracticeAt: c.lastPracticeAt,
        updatedAt: c.updatedAt,
      );

  static UserStatisticsCollection fromStatistics(
    UserStatistics e, {
    int? isarId,
  }) {
    return UserStatisticsCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..totalSpeakingSeconds = e.totalSpeakingSeconds
      ..totalSessions = e.totalSessions
      ..completedSessions = e.completedSessions
      ..expressionsSaved = e.expressionsSaved
      ..expressionsMastered = e.expressionsMastered
      ..missionsCompleted = e.missionsCompleted
      ..currentStreakDays = e.currentStreakDays
      ..longestStreakDays = e.longestStreakDays
      ..skillsMastered = e.skillsMastered
      ..achievementsUnlocked = e.achievementsUnlocked
      ..lastPracticeAt = e.lastPracticeAt
      ..updatedAt = e.updatedAt;
  }

  // ── LearningPath ──────────────────────────────────────────────────────

  static LearningPath toLearningPath(LearningPathCollection c) => LearningPath(
        id: c.domainId,
        code: c.code,
        title: c.title,
        description: c.description,
        skillIds: List<String>.from(c.skillIds),
        isDefault: c.isDefault,
      );

  static LearningPathCollection fromLearningPath(
    LearningPath e, {
    int? isarId,
  }) {
    return LearningPathCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..code = e.code
      ..title = e.title
      ..description = e.description
      ..skillIds = List<String>.from(e.skillIds)
      ..isDefault = e.isDefault;
  }

  static UserLearningPath toUserLearningPath(UserLearningPathCollection c) =>
      UserLearningPath(
        id: c.domainId,
        userId: c.userId,
        learningPathId: c.learningPathId,
        currentSkillId: c.currentSkillId,
        startedAt: c.startedAt,
      );

  static UserLearningPathCollection fromUserLearningPath(
    UserLearningPath e, {
    int? isarId,
  }) {
    return UserLearningPathCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..learningPathId = e.learningPathId
      ..currentSkillId = e.currentSkillId
      ..startedAt = e.startedAt;
  }

  // ── SpeechAnalysis ────────────────────────────────────────────────────

  static SpeechAnalysis toSpeechAnalysis(SpeechAnalysisCollection c) =>
      SpeechAnalysis(
        id: c.domainId,
        userId: c.userId,
        sessionId: c.sessionId,
        messageId: c.messageId,
        audioPath: c.audioPath,
        durationMs: c.durationMs,
        averageAmplitude: c.averageAmplitude,
        speakingRatio: c.speakingRatio,
        pauseCount: c.pauseCount,
        estimatedWords: c.estimatedWords,
        fluencyScore: c.fluencyScore,
        clarityScore: c.clarityScore,
        paceWordsPerMinute: c.paceWordsPerMinute,
        qualityBand: SpeechQualityBand.values.byName(c.qualityBand),
        notes: List<String>.from(c.notes),
        createdAt: c.createdAt,
      );

  static SpeechAnalysisCollection fromSpeechAnalysis(
    SpeechAnalysis e, {
    int? isarId,
  }) {
    return SpeechAnalysisCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..sessionId = e.sessionId
      ..messageId = e.messageId
      ..audioPath = e.audioPath
      ..durationMs = e.durationMs
      ..averageAmplitude = e.averageAmplitude
      ..speakingRatio = e.speakingRatio
      ..pauseCount = e.pauseCount
      ..estimatedWords = e.estimatedWords
      ..fluencyScore = e.fluencyScore
      ..clarityScore = e.clarityScore
      ..paceWordsPerMinute = e.paceWordsPerMinute
      ..qualityBand = e.qualityBand.name
      ..notes = List<String>.from(e.notes)
      ..createdAt = e.createdAt;
  }

  // ── Settings ──────────────────────────────────────────────────────────

  static AppSettings toSettings(AppSettingsCollection c) => AppSettings(
        id: c.domainId,
        themePreference: ThemePreference.values.byName(c.themePreference),
        interfaceLanguage: AppLanguage.fromCode(c.interfaceLanguageCode),
        hapticsEnabled: c.hapticsEnabled,
        soundEnabled: c.soundEnabled,
        dailyReminderEnabled: c.dailyReminderEnabled,
        dailyReminderHour: c.dailyReminderHour,
        dailyReminderMinute: c.dailyReminderMinute,
        autoSaveExpressions: c.autoSaveExpressions,
        showCoachHints: c.showCoachHints,
        updatedAt: c.updatedAt,
      );

  static AppSettingsCollection fromSettings(AppSettings e, {int? isarId}) {
    return AppSettingsCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..themePreference = e.themePreference.name
      ..interfaceLanguageCode = e.interfaceLanguage.code
      ..hapticsEnabled = e.hapticsEnabled
      ..soundEnabled = e.soundEnabled
      ..dailyReminderEnabled = e.dailyReminderEnabled
      ..dailyReminderHour = e.dailyReminderHour
      ..dailyReminderMinute = e.dailyReminderMinute
      ..autoSaveExpressions = e.autoSaveExpressions
      ..showCoachHints = e.showCoachHints
      ..updatedAt = e.updatedAt;
  }

  // ── ExerciseHistory ───────────────────────────────────────────────────

  static ExerciseHistoryEntry toExerciseHistory(ExerciseHistoryCollection c) =>
      ExerciseHistoryEntry(
        id: c.domainId,
        userId: c.userId,
        exerciseId: c.exerciseId,
        sessionId: c.sessionId,
        mode: PracticeMode.values.byName(c.mode),
        primarySkillId: c.primarySkillId,
        xpEarned: c.xpEarned,
        completedAt: c.completedAt,
      );

  static ExerciseHistoryCollection fromExerciseHistory(
    ExerciseHistoryEntry e, {
    int? isarId,
  }) {
    return ExerciseHistoryCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..exerciseId = e.exerciseId
      ..sessionId = e.sessionId
      ..mode = e.mode.name
      ..primarySkillId = e.primarySkillId
      ..xpEarned = e.xpEarned
      ..completedAt = e.completedAt;
  }

  // ── DailyPlan ─────────────────────────────────────────────────────────

  static DailyPlan toDailyPlan(DailyPlanCollection c) => DailyPlan(
        id: c.domainId,
        userId: c.userId,
        dayKey: c.dayKey,
        missionIds: List<String>.from(c.missionIds),
        recommendedExerciseIds: List<String>.from(c.recommendedExerciseIds),
        preferredModes: c.preferredModes
            .map(PracticeMode.values.byName)
            .toList(),
        focusSkillId: c.focusSkillId,
        primaryMissionId: c.primaryMissionId,
        createdAt: c.createdAt,
      );

  static DailyPlanCollection fromDailyPlan(DailyPlan e, {int? isarId}) {
    return DailyPlanCollection()
      ..id = isarId ?? Isar.autoIncrement
      ..domainId = e.id
      ..userId = e.userId
      ..dayKey = e.dayKey
      ..missionIds = List<String>.from(e.missionIds)
      ..recommendedExerciseIds = List<String>.from(e.recommendedExerciseIds)
      ..preferredModes = e.preferredModes.map((mode) => mode.name).toList()
      ..focusSkillId = e.focusSkillId
      ..primaryMissionId = e.primaryMissionId
      ..createdAt = e.createdAt;
  }
}
