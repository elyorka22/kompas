import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/app.dart';
import 'package:kompas/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final boot = await bootstrap();

  runApp(
    ProviderScope(
      overrides: boot.overrides,
      child: const KompasApp(),
    ),
  );
}
