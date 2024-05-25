part of 'language_bloc.dart';

@immutable
sealed class LanguageState {}

final class LanguageBlocInitial extends LanguageState {}

class LanguageLoadingState extends LanguageState {
  final LoadingInfo loadingInfo;

  LanguageLoadingState(this.loadingInfo);
}

class LanguageSuccessState extends LanguageState {
  final List<VaLanguageEntity> languages;

  LanguageSuccessState({required this.languages});
}

class LanguageErrorState extends LanguageState {
  final String title;
  final String message;
  final StatusInfoIconEnum icon;

  LanguageErrorState(this.title, this.message, this.icon);
}
