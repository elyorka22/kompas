import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/memory_enums.dart';

/// Atomic phrase / chunk tracked by Memory Engine for recall practice.
class Expression extends Equatable {
  const Expression({
    required this.id,
    required this.userId,
    required this.targetText,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
    this.nativeText,
    this.phonetic,
    this.contextExample,
    this.tags = const [],
    this.strength = MemoryStrength.newItem,
    this.easeFactor = 2.5,
    this.intervalDays = 0,
    this.repetitions = 0,
    this.nextReviewAt,
    this.lastReviewedAt,
  });

  final String id;
  final String userId;
  final String targetText;
  final String? nativeText;
  final String? phonetic;
  final String? contextExample;
  final List<String> tags;
  final ExpressionSource source;
  final MemoryStrength strength;
  final double easeFactor;
  final int intervalDays;
  final int repetitions;
  final DateTime? nextReviewAt;
  final DateTime? lastReviewedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Expression copyWith({
    String? targetText,
    String? nativeText,
    String? phonetic,
    String? contextExample,
    List<String>? tags,
    MemoryStrength? strength,
    double? easeFactor,
    int? intervalDays,
    int? repetitions,
    DateTime? nextReviewAt,
    DateTime? lastReviewedAt,
    DateTime? updatedAt,
  }) {
    return Expression(
      id: id,
      userId: userId,
      targetText: targetText ?? this.targetText,
      nativeText: nativeText ?? this.nativeText,
      phonetic: phonetic ?? this.phonetic,
      contextExample: contextExample ?? this.contextExample,
      tags: tags ?? this.tags,
      source: source,
      strength: strength ?? this.strength,
      easeFactor: easeFactor ?? this.easeFactor,
      intervalDays: intervalDays ?? this.intervalDays,
      repetitions: repetitions ?? this.repetitions,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        targetText,
        nativeText,
        phonetic,
        contextExample,
        tags,
        source,
        strength,
        easeFactor,
        intervalDays,
        repetitions,
        nextReviewAt,
        lastReviewedAt,
        createdAt,
        updatedAt,
      ];
}
