import 'package:kompas/core/errors/result.dart';

/// Contract for a single application operation.
///
/// One use case = one user intention. Keep them small and composable.
abstract class UseCase<Output, Params> {
  Future<Result<Output>> call(Params params);
}

/// Marker for use cases that need no input.
final class NoParams {
  const NoParams();
}
