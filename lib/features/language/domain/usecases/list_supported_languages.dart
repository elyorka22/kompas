import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/enums/app_language.dart';

class ListSupportedLanguages extends UseCase<List<AppLanguage>, NoParams> {
  @override
  Future<Result<List<AppLanguage>>> call(NoParams params) async {
    return Success(List<AppLanguage>.from(AppLanguage.values));
  }
}
