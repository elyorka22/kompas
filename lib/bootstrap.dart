import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/core_providers.dart';
import 'package:kompas/data/local/database/isar_database.dart';
import 'package:kompas/shared/catalog/default_learning_path_catalog.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

class BootstrapResult {
  const BootstrapResult({
    required this.database,
    required this.overrides,
  });

  final IsarDatabase database;
  final List<Override> overrides;
}

/// Opens local storage and prepares Riverpod overrides before runApp.
Future<BootstrapResult> bootstrap() async {
  final database = await IsarDatabase.open();

  final container = ProviderContainer(
    overrides: [
      isarDatabaseProvider.overrideWithValue(database),
    ],
  );

  try {
    final skills = container.read(skillRepositoryProvider);
    final paths = container.read(learningPathRepositoryProvider);
    await skills.seedIfEmpty(DefaultSkillCatalog.skills);
    await paths.seedIfEmpty(DefaultLearningPathCatalog.paths);
  } finally {
    container.dispose();
  }

  return BootstrapResult(
    database: database,
    overrides: [
      isarDatabaseProvider.overrideWithValue(database),
    ],
  );
}
