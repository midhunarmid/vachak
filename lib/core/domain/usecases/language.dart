import 'package:vachak/core/domain/entities/va_language_entity.dart';
import 'package:vachak/core/domain/repositories/language_repository.dart';

class LanguageSelectionUseCase {
  final LanguageRepository _languageRepository;

  LanguageSelectionUseCase(this._languageRepository);

  Future<List<VaLanguageEntity>> getLanguages(String supports) async {
    return await _languageRepository.getLanguages(supports);
  }
}
