import 'package:uuid/uuid.dart';

/// Generates stable string identifiers for domain entities.
///
/// Isar still uses int auto-increment locally; domain IDs stay UUID strings
/// so entities can sync later without rewriting identity.
abstract final class IdGenerator {
  static const Uuid _uuid = Uuid();

  static String v4() => _uuid.v4();
}
