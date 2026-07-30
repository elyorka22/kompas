import 'package:equatable/equatable.dart';

/// Why Coach Engine made a pedagogical choice.
class RecommendationReason extends Equatable {
  const RecommendationReason({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;

  @override
  List<Object?> get props => [code, message];
}

/// A recommendation that always carries human-readable reasons.
class CoachedRecommendation<T> extends Equatable {
  const CoachedRecommendation({
    required this.value,
    required this.reasons,
    this.confidence = 0.7,
  });

  final T value;
  final List<RecommendationReason> reasons;
  final double confidence;

  @override
  List<Object?> get props => [value, reasons, confidence];
}
