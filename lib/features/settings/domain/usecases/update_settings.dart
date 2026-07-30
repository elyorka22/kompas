import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/app_settings.dart';
import 'package:kompas/domain/repositories/settings_repository.dart';

class UpdateSettings extends UseCase<AppSettings, AppSettings> {
  UpdateSettings(this._settings);

  final SettingsRepository _settings;

  @override
  Future<Result<AppSettings>> call(AppSettings params) {
    return _settings.save(
      params.copyWith(updatedAt: DateTime.now().toUtc()),
    );
  }
}
