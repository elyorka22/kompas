import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/data/local/collections/app_settings_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/app_settings.dart';
import 'package:kompas/domain/repositories/settings_repository.dart';

class IsarSettingsRepository implements SettingsRepository {
  IsarSettingsRepository(this._isar);

  final Isar _isar;
  static const String _singletonDomainId = 'app_settings';

  @override
  Future<Result<AppSettings>> get() async {
    try {
      final existing = await _isar.appSettingsCollections
          .filter()
          .domainIdEqualTo(_singletonDomainId)
          .findFirst();
      if (existing != null) {
        return Success(EntityMappers.toSettings(existing));
      }
      final defaults = AppSettings(
        id: _singletonDomainId,
        updatedAt: DateTime.now().toUtc(),
      );
      return save(defaults);
    } catch (error) {
      return Err(StorageFailure('Failed to load settings', cause: error));
    }
  }

  @override
  Future<Result<AppSettings>> save(AppSettings settings) async {
    try {
      final normalized = settings.id == _singletonDomainId
          ? settings
          : settings.copyWith(updatedAt: settings.updatedAt);
      final withId = AppSettings(
        id: _singletonDomainId,
        themePreference: normalized.themePreference,
        interfaceLanguage: normalized.interfaceLanguage,
        hapticsEnabled: normalized.hapticsEnabled,
        soundEnabled: normalized.soundEnabled,
        dailyReminderEnabled: normalized.dailyReminderEnabled,
        dailyReminderHour: normalized.dailyReminderHour,
        dailyReminderMinute: normalized.dailyReminderMinute,
        autoSaveExpressions: normalized.autoSaveExpressions,
        showCoachHints: normalized.showCoachHints,
        updatedAt: DateTime.now().toUtc(),
      );
      final existing = await _isar.appSettingsCollections
          .filter()
          .domainIdEqualTo(_singletonDomainId)
          .findFirst();
      final mapped =
          EntityMappers.fromSettings(withId, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.appSettingsCollections.put(mapped);
      });
      return Success(withId);
    } catch (error) {
      return Err(StorageFailure('Failed to save settings', cause: error));
    }
  }
}
