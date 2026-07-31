/// Application route path constants.
abstract final class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcomeMission = '/welcome-mission';
  static const String coach = '/coach';
  static const String home = '/home';
  static const String practice = '/practice';
  static const String notebook = '/notebook';
  static const String skills = '/skills';
  static const String progress = '/progress';
  static const String settings = '/settings';
  static const String session = '/session/:id';
  static const String sessionComplete = '/session/:id/complete';

  static String sessionPath(String id) => '/session/$id';
  static String sessionCompletePath(String id) => '/session/$id/complete';
}
