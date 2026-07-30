import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/app_settings.dart';

abstract class SettingsRepository {
  Future<Result<AppSettings>> get();
  Future<Result<AppSettings>> save(AppSettings settings);
}
