import 'package:flutter_test/flutter_test.dart';
import 'package:kompas/core/constants/app_constants.dart';
import 'package:kompas/services/memory/memory_engine_service.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/domain/enums/memory_enums.dart';

void main() {
  test('MemoryEngineService advances interval on good recall', () {
    final engine = MemoryEngineService();
    final expression = Expression(
      id: 'e1',
      userId: 'u1',
      targetText: 'How have you been?',
      source: ExpressionSource.manual,
      createdAt: DateTime.utc(2026, 1, 1),
      updatedAt: DateTime.utc(2026, 1, 1),
    );

    final reviewed = engine.review(expression, quality: 5);

    expect(reviewed.repetitions, 1);
    expect(reviewed.intervalDays, 1);
    expect(reviewed.strength, MemoryStrength.learning);
  });

  test('App name is Compass brand', () {
    expect(AppConstants.appName, 'Компас');
  });
}
