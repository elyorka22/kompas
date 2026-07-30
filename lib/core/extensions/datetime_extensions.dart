import 'package:kompas/core/utils/date_utils.dart';

extension KompasDateTimeX on DateTime {
  DateTime get startOfDay => KompasDateUtils.startOfDay(this);

  bool isSameDayAs(DateTime other) => KompasDateUtils.isSameDay(this, other);

  String get dayKey => KompasDateUtils.dayKey(this);
}
