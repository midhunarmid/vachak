import 'package:vachak/core/domain/entities/va_language_entity.dart';

abstract class LanguageRepository {
  Future<List<VaLanguageEntity>> getLanguages(String supports);
}
