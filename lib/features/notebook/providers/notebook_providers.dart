import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/domain/entities/notebook_item.dart';
import 'package:kompas/features/notebook/domain/usecases/list_notebook_items.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';

final notebookItemsProvider =
    FutureProvider<List<NotebookItem>>((ref) async {
  final user = await ref.watch(activeUserProvider.future);
  if (user == null) return const [];
  final result = await ref.watch(listNotebookItemsProvider)(
    ListNotebookItemsParams(userId: user.id),
  );
  return result.valueOrNull ?? const [];
});
