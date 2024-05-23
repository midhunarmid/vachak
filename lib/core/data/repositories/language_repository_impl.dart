import 'package:vachak/core/data/datasources/local_data_source.dart';
import 'package:vachak/core/data/datasources/remote_data_source.dart';
import 'package:vachak/core/domain/entities/va_language_entity.dart';
import 'package:vachak/core/domain/repositories/language_repository.dart';

class LanguageRepositoryImpl extends LanguageRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  LanguageRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<List<VaLanguageEntity>> getLanguages(String supports) async {
    List<VaLanguageEntity> cachedItems =
        await _localDataSource.getLanguages(supports: supports);
    List<VaLanguageEntity> serverItems =
        await _remoteDataSource.getLanguages(supports: supports);
    return [...cachedItems, ...serverItems];
  }
}
