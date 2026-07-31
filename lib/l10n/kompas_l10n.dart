import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kompas/domain/enums/app_language.dart';

/// UI languages available in Settings (v1).
abstract final class InterfaceLanguages {
  static const options = <AppLanguage>[AppLanguage.ru, AppLanguage.uz];

  static AppLanguage normalize(AppLanguage language) {
    if (language == AppLanguage.uz) return AppLanguage.uz;
    return AppLanguage.ru;
  }

  static Locale toLocale(AppLanguage language) {
    return Locale(normalize(language).code);
  }
}

/// Application strings for Russian and Uzbek interface.
class KompasL10n {
  const KompasL10n(this.language);

  final AppLanguage language;

  static KompasL10n of(BuildContext context) {
    return Localizations.of<KompasL10n>(context, KompasL10n)!;
  }

  bool get isUz => language == AppLanguage.uz;

  String _t({required String ru, required String uz}) => isUz ? uz : ru;

  // ── Common ────────────────────────────────────────────────────────────
  String get appName => 'Kompas';
  String get continueLabel => _t(ru: 'Продолжить', uz: 'Davom etish');
  String get back => _t(ru: 'Назад', uz: 'Orqaga');
  String get open => _t(ru: 'Открыть', uz: 'Ochish');
  String get settings => _t(ru: 'Настройки', uz: 'Sozlamalar');
  String get loading => _t(ru: 'Загрузка…', uz: 'Yuklanmoqda…');
  String get saving => _t(ru: 'Сохранение…', uz: 'Saqlanmoqda…');

  // ── Navigation ────────────────────────────────────────────────────────
  String get navHome => _t(ru: 'Сегодня', uz: 'Bugun');
  String get navCoach => _t(ru: 'Коуч', uz: 'Murabbiy');
  String get navPractice => _t(ru: 'Практика', uz: 'Mashq');
  String get navMissions => _t(ru: 'Миссии', uz: 'Missiyalar');
  String get navNotebook => _t(ru: 'Выражения', uz: 'Iboralar');
  String get navSkills => _t(ru: 'Навыки', uz: 'Ko‘nikmalar');
  String get navProgress => _t(ru: 'Прогресс', uz: 'Taraqqiyot');

  // ── Coach chat ────────────────────────────────────────────────────────
  String get welcomeBack =>
      _t(ru: 'С возвращением.', uz: 'Qaytganingiz bilan.');
  String get todayTrainSpokenRussian => _t(
        ru: 'Сегодня потренируем разговорный русский.',
        uz: 'Bugun og‘zaki rus tilini mashq qilamiz.',
      );
  String get todaysGoal => _t(ru: 'Цель на сегодня', uz: 'Bugungi maqsad');
  String get todayRussianFocus => _t(
        ru: 'Говорите естественно и не переводите слово в слово.',
        uz: 'Tabiiy gapiring va so‘zma-so‘z tarjima qilmang.',
      );
  String goalUseExpressions(String expressions) => _t(
        ru: 'Используйте естественно: $expressions',
        uz: 'Tabiiy ishlating: $expressions',
      );
  String get suggestedTopics =>
      _t(ru: 'Темы для разговора', uz: 'Suhbat mavzulari');
  String get quickSuggestions =>
      _t(ru: 'Быстрый старт', uz: 'Tezkor start');
  String get chatHint =>
      _t(ru: 'Напишите на русском…', uz: 'Ruscha yozing…');
  String get voiceSoon =>
      _t(ru: 'Голос скоро', uz: 'Ovoz tez orada');
  String get voiceInput =>
      _t(ru: 'Голосовой ввод', uz: 'Ovozli kiritish');
  String get voiceAutoSend => _t(
        ru: 'Автоотправка после распознавания',
        uz: 'Tanib bo‘lgach avto-yuborish',
      );
  String get voiceAutoSendSubtitle => _t(
        ru: 'После «Готово» сообщение сразу уходит коучу',
        uz: '«Tayyor» dan so‘ng xabar murabbiyga yuboriladi',
      );
  String get speechSection =>
      _t(ru: 'Распознавание речи', uz: 'Nutqni aniqlash');
  String get speechEngineLabel =>
      _t(ru: 'Движок: Whisper Offline (русский)', uz: 'Dvigatel: Whisper Offline (rus)');
  String get speechModelLabel => _t(ru: 'Модель', uz: 'Model');
  String get speechModelSmall =>
      _t(ru: 'Small (рекомендуется)', uz: 'Small (tavsiya)');
  String get speechModelBase => _t(ru: 'Base', uz: 'Base');
  String get speechModelDownloaded =>
      _t(ru: 'Скачана', uz: 'Yuklab olingan');
  String get speechModelMissing =>
      _t(ru: 'Не скачана', uz: 'Yuklanmagan');
  String get speechDownloadModel =>
      _t(ru: 'Скачать модель', uz: 'Modelni yuklash');
  String get speechDeleteModel =>
      _t(ru: 'Удалить модель', uz: 'Modelni o‘chirish');
  String get speechRussianOnlyHint => _t(
        ru: 'Распознавание только русского. Другие языки не поддерживаются.',
        uz: 'Faqat rus tili aniqlanadi. Boshqa tillar qo‘llab-quvvatlanmaydi.',
      );
  String get attachSoon =>
      _t(ru: 'Вложения скоро', uz: 'Ilovalar tez orada');
  String get coachTyping =>
      _t(ru: 'Коуч печатает…', uz: 'Murabbiy yozmoqda…');
  String get openaiApiKey =>
      _t(ru: 'DeepSeek API ключ', uz: 'DeepSeek API kaliti');
  String get openaiApiKeyHint => _t(
        ru: 'Ключ DeepSeek хранится на устройстве. Телефон ходит к AI напрямую.',
        uz: 'DeepSeek kaliti qurilmada saqlanadi. Telefon AI ga to‘g‘ridan-to‘g‘ri ulanadi.',
      );
  String get saveApiKey => _t(ru: 'Сохранить ключ', uz: 'Kalitni saqlash');
  String get apiKeySaved =>
      _t(ru: 'Ключ сохранён', uz: 'Kalit saqlandi');
  String get aiSection => _t(ru: 'ИИ-коуч (DeepSeek)', uz: 'AI murabbiy (DeepSeek)');

  // ── Splash ────────────────────────────────────────────────────────────
  String get splashTagline => _t(
        ru: 'AI-коуч разговорного русского',
        uz: 'Og‘zaki rus tili uchun AI murabbiy',
      );

  // ── Settings ──────────────────────────────────────────────────────────
  String get appearance => _t(ru: 'Оформление', uz: 'Ko‘rinish');
  String get themeSystem => _t(ru: 'Система', uz: 'Tizim');
  String get themeLight => _t(ru: 'Светлая', uz: 'Yorug‘');
  String get themeDark => _t(ru: 'Тёмная', uz: 'Qorong‘u');
  String get interfaceLanguage =>
      _t(ru: 'Язык интерфейса', uz: 'Interfeys tili');
  String get practiceSection => _t(ru: 'Практика', uz: 'Mashq');
  String get coachHints => _t(ru: 'Подсказки коуча', uz: 'Murabbiy maslahatlari');
  String get autoSaveExpressions =>
      _t(ru: 'Автосохранение выражений', uz: 'Iboralarni avto-saqlash');

  // ── Onboarding ────────────────────────────────────────────────────────
  String get onboardingPhilosophy => _t(
        ru: 'Компас не учит за вас.\nКомпас ведёт ваш путь.',
        uz: 'Kompas sizning o‘rniga o‘qitmaydi.\nKompas yo‘lingizni ko‘rsatadi.',
      );
  String get onboardingSpeakReflect =>
      _t(ru: 'Говорите. Осмысляйте. Растите.', uz: 'Gapiring. O‘ylang. O‘sing.');
  String get onboardingSpeakReflectBody => _t(
        ru:
            'Ежедневные миссии, прогресс навыков и память — всё офлайн и осознанно.',
        uz:
            'Kundalik missiyalar, ko‘nikmalar va xotira — hammasi oflayn va ongli.',
      );
  String get onboardingCoachNotGame =>
      _t(ru: 'Коуч, а не игра.', uz: 'O‘yin emas — murabbiy.');
  String get onboardingCoachNotGameBody => _t(
        ru:
            'Спокойное руководство. Настоящая разговорная практика. Премиальный фокус — без детских упражнений.',
        uz:
            'Sokin yo‘l-yo‘riq. Haqiqiy suhbat mashqi. Premium e’tibor — bolalarcha mashqlarsiz.',
      );
  String get createProfile => _t(ru: 'Создать профиль', uz: 'Profil yaratish');
  String get yourProfile => _t(ru: 'Ваш профиль', uz: 'Profilingiz');
  String get nameLabel => _t(ru: 'Имя', uz: 'Ism');
  String get nameHint => _t(
        ru: 'Как Компас должен к вам обращаться?',
        uz: 'Kompas sizni qanday chaqirsin?',
      );
  String get iSpeak => _t(ru: 'Я говорю', uz: 'Men gapiraman');
  String get iWantToSpeak => _t(ru: 'Хочу говорить на', uz: 'Gapirishni xohlayman');
  String get pleaseEnterName =>
      _t(ru: 'Пожалуйста, введите имя', uz: 'Iltimos, ismingizni kiriting');
  String get yourRhythm => _t(ru: 'Ваш ритм', uz: 'Ritmingiz');
  String get learningGoal => _t(ru: 'Цель обучения', uz: 'O‘quv maqsadi');
  String get dailyPracticeTime =>
      _t(ru: 'Ежедневная практика', uz: 'Kunlik mashq');
  String minutesLabel(int minutes) =>
      _t(ru: '$minutes мин', uz: '$minutes daqiqa');
  String get dailyReminder =>
      _t(ru: 'Ежедневное напоминание', uz: 'Kunlik eslatma');
  String get dailyReminderSubtitle =>
      _t(ru: 'Тихий сигнал в 09:00', uz: 'Soat 09:00 da sokin eslatma');
  String get beginJourney => _t(ru: 'Начать путь', uz: 'Yo‘lni boshlash');
  String get preparingCompass =>
      _t(ru: 'Готовим Компас…', uz: 'Kompas tayyorlanmoqda…');

  String get goalWork =>
      _t(ru: 'Уверенно говорить на работе', uz: 'Ishda ishonchli gapirish');
  String get goalTravel =>
      _t(ru: 'Свободно в путешествиях', uz: 'Sayohatda erkin gapirish');
  String get goalEveryday =>
      _t(ru: 'Повседневные разговоры', uz: 'Kundalik suhbatlar');
  String get goalStudy =>
      _t(ru: 'Учёба и академическая речь', uz: 'O‘qish va akademik nutq');

  static const goalKeyWork = 'goal_work';
  static const goalKeyTravel = 'goal_travel';
  static const goalKeyEveryday = 'goal_everyday';
  static const goalKeyStudy = 'goal_study';

  List<({String key, String label})> get learningGoals => [
        (key: goalKeyWork, label: goalWork),
        (key: goalKeyTravel, label: goalTravel),
        (key: goalKeyEveryday, label: goalEveryday),
        (key: goalKeyStudy, label: goalStudy),
      ];

  String learningGoalLabel(String key) {
    return switch (key) {
      goalKeyWork || 'Speak confidently at work' => goalWork,
      goalKeyTravel || 'Travel with ease' => goalTravel,
      goalKeyEveryday || 'Everyday conversations' => goalEveryday,
      goalKeyStudy || 'Study and academic speech' => goalStudy,
      _ => key,
    };
  }

  // ── Welcome mission ───────────────────────────────────────────────────
  String get firstMissionTitle =>
      _t(ru: 'Ваша первая миссия', uz: 'Birinchi missiyangiz');
  String get firstMissionBody => _t(
        ru: 'Compass Engine подготовил сегодняшний путь по вашему профилю.',
        uz: 'Compass Engine profilingiz asosida bugungi yo‘lni tayyorladi.',
      );
  String get missionsAppearLater => _t(
        ru: 'Миссии появятся, когда вы начнёте практиковать.',
        uz: 'Mashq qilganda missiyalar paydo bo‘ladi.',
      );
  String get openDashboard => _t(ru: 'Открыть главную', uz: 'Asosiyni ochish');

  // ── Home ──────────────────────────────────────────────────────────────
  String get welcome => _t(ru: 'Добро пожаловать', uz: 'Xush kelibsiz');
  String helloName(String name) =>
      _t(ru: 'Привет, $name', uz: 'Salom, $name');
  String goodMorningName(String name) =>
      _t(ru: 'Доброе утро, $name.', uz: 'Xayrli tong, $name.');
  String goodAfternoonName(String name) =>
      _t(ru: 'Добрый день, $name.', uz: 'Hayrli kun, $name.');
  String goodEveningName(String name) =>
      _t(ru: 'Добрый вечер, $name.', uz: 'Hayrli kech, $name.');
  String get coachRecommendsToday => _t(
        ru: 'Сегодня коуч рекомендует',
        uz: 'Bugun murabbiy tavsiya qiladi',
      );
  String get reasonLabel => _t(ru: 'Почему', uz: 'Nima uchun');
  String get startTodaysSession =>
      _t(ru: 'Начать сегодняшнюю сессию', uz: 'Bugungi sessiyani boshlash');
  String get todaysProgress =>
      _t(ru: 'Прогресс сегодня', uz: 'Bugungi taraqqiyot');
  String get missionsLoading => _t(
        ru: 'Миссии загружает Compass Engine',
        uz: 'Missiyalarni Compass Engine yuklaydi',
      );
  String missionsCount(int done, int total) =>
      _t(ru: '$done/$total миссий', uz: '$done/$total missiya');
  String streakDays(int days) => days == 1
      ? _t(ru: '1 день серии', uz: '1 kunlik seriya')
      : _t(ru: '$days дней серии', uz: '$days kunlik seriya');
  String get todaysMission =>
      _t(ru: 'Миссия на сегодня', uz: 'Bugungi missiya');
  String get todaysMissionSubtitle => _t(
        ru: 'Сгенерировано офлайн Compass Engine',
        uz: 'Compass Engine tomonidan oflayn yaratilgan',
      );
  String get noMissionsYet => _t(
        ru: 'Пока нет миссий. Начните практику, чтобы начать.',
        uz: 'Hali missiya yo‘q. Boshlash uchun mashq qiling.',
      );
  String get continuePractice =>
      _t(ru: 'Продолжить практику', uz: 'Mashqni davom ettirish');
  String get coachWillRecommend => _t(
        ru: 'Coach Engine предложит следующее упражнение.',
        uz: 'Coach Engine keyingi mashqni tavsiya qiladi.',
      );
  String get openPractice => _t(ru: 'Открыть практику', uz: 'Mashqni ochish');
  String get notebook => _t(ru: 'Блокнот', uz: 'Daftar');
  String get notebookHomeHint => _t(
        ru: 'Ваша база знаний — слова, выражения, ошибки.',
        uz: 'Bilim bazangiz — so‘zlar, iboralar, xatolar.',
      );
  String get openNotebook => _t(ru: 'Открыть блокнот', uz: 'Daftarni ochish');
  String get recentAchievements =>
      _t(ru: 'Недавние достижения', uz: 'So‘nggi yutuqlar');
  String get skillProgress =>
      _t(ru: 'Прогресс навыков', uz: 'Ko‘nikmalar taraqqiyoti');
  String get skillXpAfterSession => _t(
        ru: 'XP навыков появится после первой завершённой сессии.',
        uz: 'Birinchi sessiyadan keyin ko‘nikma XP paydo bo‘ladi.',
      );
  String get recentActivity =>
      _t(ru: 'Недавняя активность', uz: 'So‘nggi faoliyat');
  String get finishSessionForActivity => _t(
        ru: 'Завершите сессию, чтобы увидеть ленту активности.',
        uz: 'Faoliyatni ko‘rish uchun sessiyani yakunlang.',
      );

  // ── Practice ──────────────────────────────────────────────────────────
  String get practiceTitle => _t(ru: 'Практика', uz: 'Mashq');
  String get practiceSubtitle => _t(
        ru: 'Одна миссия. Один фокус. Ваш коуч уже выбрал.',
        uz: 'Bitta missiya. Bitta fokus. Murabbiyingiz tanladi.',
      );
  String get noExerciseYet =>
      _t(ru: 'Упражнение пока недоступно.', uz: 'Hali mashq yo‘q.');
  String get recommendedByCoach =>
      _t(ru: 'Рекомендовано коучем', uz: 'Murabbiy tavsiyasi');
  String get start => _t(ru: 'Начать', uz: 'Boshlash');
  String get startMission => _t(ru: 'Начать миссию', uz: 'Missiyani boshlash');
  String get practiceModes =>
      _t(ru: 'Другие миссии', uz: 'Boshqa missiyalar');
  String get estimatedMinutes =>
      _t(ru: '~2 мин', uz: '~2 daqiqa');
  String difficultyLabel(String name) {
    return switch (name) {
      'starter' => _t(ru: 'Старт', uz: 'Boshlanish'),
      'core' => _t(ru: 'Основной', uz: 'Asosiy'),
      'stretch' => _t(ru: 'Сложный', uz: 'Murakkab'),
      _ => name,
    };
  }
  String skillsTrained(String skill) =>
      _t(ru: 'Навык: $skill', uz: 'Ko‘nikma: $skill');

  String practiceModeTitle(String modeName) {
    return switch (modeName) {
      'explainWord' => _t(ru: 'Объяснить слово', uz: 'So‘zni tushuntirish'),
      'continueStory' =>
        _t(ru: 'Продолжить историю', uz: 'Hikoyani davom ettirish'),
      'describeImage' =>
        _t(ru: 'Описать изображение', uz: 'Rasmni tasvirlash'),
      'tellAboutDay' =>
        _t(ru: 'Рассказать о дне', uz: 'Kun haqida gapirish'),
      'defendOpinion' =>
        _t(ru: 'Защитить мнение', uz: 'Fikrni himoya qilish'),
      'retellText' => _t(ru: 'Пересказать текст', uz: 'Matnni qayta aytish'),
      'explainIdiom' =>
        _t(ru: 'Объяснить идиому', uz: 'Idiomani tushuntirish'),
      _ => modeName,
    };
  }

  // ── Session ───────────────────────────────────────────────────────────
  String get sessionNotFound =>
      _t(ru: 'Сессия не найдена', uz: 'Sessiya topilmadi');
  String sessionEarnXp(int xp) => _t(
        ru: 'Офлайн-практика · +$xp XP за завершение',
        uz: 'Oflayn mashq · yakunlash uchun +$xp XP',
      );
  String get coachPrompt => _t(ru: 'Подсказка коуча', uz: 'Murabbiy topshirig‘i');
  String get speakNow => _t(
        ru:
            'Говорите вслух. Компас слышит через ваше усилие — не через ИИ-микрофон.',
        uz:
            'Ovoz chiqarib gapiring. Kompas AI mikrofon emas — sizning harakatingizni hisoblaydi.',
      );
  String get startTimerHint => _t(
        ru: 'Запустите таймер, говорите около двух минут, затем завершите.',
        uz: 'Taymerni yoqing, taxminan ikki daqiqa gapiring, keyin yakunlang.',
      );
  String get sessionNotes => _t(ru: 'Заметки сессии', uz: 'Sessiya eslatmalari');
  String get capturePhrase =>
      _t(ru: 'Сохранить фразу (необязательно)', uz: 'Iborani saqlash (ixtiyoriy)');
  String get capturePhraseHint => _t(
        ru: 'Предложение, которое вы потренировали — в Memory Engine',
        uz: 'Mashq qilgan gapingiz — Memory Engine ga saqlanadi',
      );
  String get pauseTimer => _t(ru: 'Пауза', uz: 'Pauza');
  String get startSpeakingTimer =>
      _t(ru: 'Старт таймера речи', uz: 'Nutq taymerini boshlash');
  String get finishSession =>
      _t(ru: 'Завершить сессию', uz: 'Sessiyani yakunlash');

  // ── Session complete ──────────────────────────────────────────────────
  String get backHome => _t(ru: 'На главную', uz: 'Asosiyga');
  String get sessionComplete =>
      _t(ru: 'Сессия завершена', uz: 'Sessiya yakunlandi');
  String get sessionRecordedOffline => _t(
        ru: 'Компас сохранил практику офлайн.',
        uz: 'Kompas mashqni oflayn saqladi.',
      );
  String get speaking => _t(ru: 'Речь', uz: 'Nutq');
  String get xpEarned => _t(ru: 'Получено XP', uz: 'Olingan XP');
  String get streak => _t(ru: 'Серия', uz: 'Seriya');
  String get sessions => _t(ru: 'Сессии', uz: 'Sessiyalar');
  String get skillGrowth =>
      _t(ru: 'Рост навыков', uz: 'Ko‘nikmalar o‘sishi');
  String get noSkillXp =>
      _t(ru: 'В этот раз XP навыков не начислено.', uz: 'Bu safar XP yo‘q.');
  String get coachRecommendation =>
      _t(ru: 'Рекомендация коуча', uz: 'Murabbiy tavsiyasi');
  String get keepSteadyRhythm => _t(
        ru: 'Держите спокойный ритм речи завтра.',
        uz: 'Ertaga ham sokin nutq ritmini saqlang.',
      );
  String get coachPreparingFocus => _t(
        ru: 'Coach Engine готовит следующий фокус.',
        uz: 'Coach Engine keyingi fokusni tayyorlamoqda.',
      );
  String get nextSuggestedExercise =>
      _t(ru: 'Следующее упражнение', uz: 'Keyingi mashq');
  String get openPracticeToContinue =>
      _t(ru: 'Откройте Практику, чтобы продолжить.', uz: 'Davom etish uchun Mashqni oching.');
  String get backToDashboard =>
      _t(ru: 'На главную', uz: 'Asosiyga qaytish');
  String get viewProgress =>
      _t(ru: 'Смотреть прогресс', uz: 'Taraqqiyotni ko‘rish');

  // ── Progress ──────────────────────────────────────────────────────────
  String get progressTitle => _t(ru: 'Прогресс', uz: 'Taraqqiyot');
  String get progressSubtitle => _t(
        ru: 'История вашего роста — не таблица цифр.',
        uz: 'O‘sishingiz hikoyasi — raqamlar jadvali emas.',
      );
  String get yourStory => _t(ru: 'Ваша история', uz: 'Sizning hikoyangiz');
  String spokeThisWeek(int minutes) => _t(
        ru: 'На этой неделе вы говорили $minutes минут.',
        uz: 'Bu hafta $minutes daqiqa gapirdingiz.',
      );
  String improvedSkill(String skill, int percent) => _t(
        ru: 'Вы продвинулись в «$skill» на $percent%.',
        uz: '«$skill» bo‘yicha $percent% o‘sdingiz.',
      );
  String streakStory(int days) => days <= 0
      ? _t(
          ru: 'Начните серию сегодня — коуч рядом.',
          uz: 'Bugun seriyani boshlang — murabbiy yonida.',
        )
      : _t(
          ru: 'Ваша серия — $days ${_dayWord(days)}. Держите ритм.',
          uz: 'Seriyangiz — $days kun. Ritmni saqlang.',
        );
  String _dayWord(int days) {
    if (days % 10 == 1 && days % 100 != 11) return 'день';
    if (days % 10 >= 2 && days % 10 <= 4 && (days % 100 < 10 || days % 100 >= 20)) {
      return 'дня';
    }
    return 'дней';
  }

  String coachNextFocus(String skill) => _t(
        ru: 'Коуч рекомендует дальше: $skill.',
        uz: 'Murabbiy keyingi fokus: $skill.',
      );
  String get completeSessionForProgress => _t(
        ru: 'Завершите сессию, чтобы открыть прогресс.',
        uz: 'Taraqqiyotni ochish uchun sessiyani yakunlang.',
      );
  String bestStreak(int days) =>
      _t(ru: 'Рекорд $days', uz: 'Rekord $days');
  String get weeklyActivity =>
      _t(ru: 'Ритм', uz: 'Ritm');
  String get noWeeklyYet => _t(
        ru: 'Пока нет завершённых сессий. Здесь появится ваш ритм.',
        uz: 'Hali sessiya yo‘q. Bu yerda ritmingiz paydo bo‘ladi.',
      );
  String recentSessionsSummary(int count, int minutes) => _t(
        ru: '$count недавних сессий · $minutes мин',
        uz: '$count so‘nggi sessiya · $minutes daqiqa',
      );
  String get towardWeeklyCadence => _t(
        ru: 'К устойчивому недельному ритму речи',
        uz: 'Barqaror haftalik nutq ritmiga qarab',
      );
  String get skills => _t(ru: 'Навыки', uz: 'Ko‘nikmalar');
  String get skillGrowthStarts => _t(
        ru: 'Рост навыков начинается после первой сессии.',
        uz: 'Ko‘nikmalar birinchi sessiyadan keyin o‘sadi.',
      );
  String get learningPath => _t(ru: 'Путь обучения', uz: 'O‘quv yo‘li');
  String get pathUnavailable =>
      _t(ru: 'Путь недоступен', uz: 'Yo‘l mavjud emas');
  String skillsOnPath(int count) =>
      _t(ru: '$count навыков на этом пути', uz: 'Bu yo‘lda $count ko‘nikma');
  String get achievements => _t(ru: 'Достижения', uz: 'Yutuqlar');
  String get achievementsEmpty => _t(
        ru: 'Достижения открываются с практикой — пока пусто.',
        uz: 'Yutuqlar mashq bilan ochiladi — hozircha bo‘sh.',
      );
  String get unlocked => _t(ru: 'Открыто', uz: 'Ochilgan');
  String get locked => _t(ru: 'Закрыто', uz: 'Yopiq');
  String get memoryInsights =>
      _t(ru: 'Инсайты коуча', uz: 'Murabbiy tushunchalari');

  // ── Notebook / Skills shell ───────────────────────────────────────────
  String get notebookTitle => _t(ru: 'Блокнот', uz: 'Daftar');
  String get notebookSubtitle => _t(
        ru: 'Слова с переводом и примерами',
        uz: 'Tarjima va misollar bilan so‘zlar',
      );
  String get notebookEmpty => _t(
        ru:
            'Пока пусто. Напишите коучу: «добавь в блокнот слово небоскрёб с переводом и примерами» — или нажмите +.',
        uz:
            'Hali bo‘sh. Murabbiyga yozing: «блокнотга небоскрёб so‘zini tarjima va misollar bilan qo‘sh» — yoki + ni bosing.',
      );
  String get notebookSearchHint =>
      _t(ru: 'Поиск слова…', uz: 'So‘z qidirish…');
  String get notebookChatHint => _t(
        ru:
            'Через чат: «добавь в блокнот слово … с переводом и примерами» (можно голосом).',
        uz:
            'Chat orqali: «блокнотга … so‘zini tarjima va misollar bilan qo‘sh» (ovoz bilan ham).',
      );
  String get notebookAddWord =>
      _t(ru: 'Добавить слово', uz: 'So‘z qo‘shish');
  String get notebookExamples => _t(ru: 'Примеры', uz: 'Misollar');
  String get notebookWordLabel => _t(ru: 'Слово', uz: 'So‘z');
  String get notebookTranslationLabel =>
      _t(ru: 'Перевод', uz: 'Tarjima');
  String notebookExampleLabel(int n) =>
      _t(ru: 'Пример $n', uz: 'Misol $n');
  String get save => _t(ru: 'Сохранить', uz: 'Saqlash');
  String get notebookPinned => _t(ru: 'Закреплённые', uz: 'Qadalganlar');
  String get notebookRecent => _t(ru: 'Недавно', uz: 'Yaqinda');
  String get notebookAll => _t(ru: 'Все', uz: 'Hammasi');
  String get notebookFilterWords => _t(ru: 'Слова', uz: 'So‘zlar');
  String get notebookFilterExpressions =>
      _t(ru: 'Выражения', uz: 'Iboralar');
  String get notebookFilterIdioms => _t(ru: 'Идиомы', uz: 'Idiomalar');
  String get notebookFilterMistakes => _t(ru: 'Ошибки', uz: 'Xatolar');
  String get notebookFilterFavorites =>
      _t(ru: 'Избранное', uz: 'Sevimlilar');
  String get notebookFilterNotes => _t(ru: 'Заметки', uz: 'Eslatmalar');
  String get skillTreeTitle => _t(ru: 'Русский путь', uz: 'Rus yo‘li');
  String get skillTreeSubtitle => _t(
        ru: 'Разговор, падежи, аспекты, движение, идиомы.',
        uz: 'Suhbat, kelishiklar, aspektlar, harakat, idiomalar.',
      );
  String get completeOnboardingForPath => _t(
        ru: 'Завершите онбординг, чтобы открыть путь.',
        uz: 'Yo‘lni ochish uchun onboardingni yakunlang.',
      );
  String get skillStatusLocked => _t(ru: 'Закрыт', uz: 'Yopiq');
  String get skillStatusAvailable => _t(ru: 'Доступен', uz: 'Mavjud');
  String get skillStatusGrowing => _t(ru: 'Растёт', uz: 'O‘smoqda');
  String get skillStatusMastered => _t(ru: 'Освоен', uz: 'O‘zlashtirilgan');
  String skillXpLabel(int xp, int target) =>
      _t(ru: '$xp / $target XP', uz: '$xp / $target XP');
}

class KompasL10nDelegate extends LocalizationsDelegate<KompasL10n> {
  const KompasL10nDelegate();

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'ru' || locale.languageCode == 'uz';
  }

  @override
  Future<KompasL10n> load(Locale locale) {
    final language = InterfaceLanguages.normalize(
      AppLanguage.fromCode(locale.languageCode),
    );
    return SynchronousFuture<KompasL10n>(KompasL10n(language));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<KompasL10n> old) => false;
}

/// Material/Cupertino have no Uzbek catalogs — fall back to Russian widgets.
class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    final fallback = locale.languageCode == 'uz'
        ? const Locale('ru')
        : locale;
    return GlobalMaterialLocalizations.delegate.load(fallback);
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<MaterialLocalizations> old,
  ) =>
      false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    final fallback = locale.languageCode == 'uz'
        ? const Locale('ru')
        : locale;
    return GlobalCupertinoLocalizations.delegate.load(fallback);
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<CupertinoLocalizations> old,
  ) =>
      false;
}
