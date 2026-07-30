/// Typed failure hierarchy for domain and data layers.
///
/// Failures travel through [Result] and are converted to user-facing
/// messages only at the presentation boundary.
sealed class Failure {
  const Failure(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

/// Local persistence could not complete (Isar I/O, disk full, etc.).
final class StorageFailure extends Failure {
  const StorageFailure(super.message, {super.cause});
}

/// Requested entity was not found in local storage.
final class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.cause});
}

/// Input failed domain validation before any write.
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.cause});
}

/// Platform capability is unavailable (mic permission, recorder, etc.).
final class PlatformFailure extends Failure {
  const PlatformFailure(super.message, {super.cause});
}

/// Feature is intentionally unavailable in the current product version.
final class UnsupportedFailure extends Failure {
  const UnsupportedFailure(super.message, {super.cause});
}

/// Catch-all for unexpected errors that escaped typed handling.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {super.cause});
}
