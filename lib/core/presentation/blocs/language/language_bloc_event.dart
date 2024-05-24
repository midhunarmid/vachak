part of 'language_bloc_bloc.dart';

@immutable
sealed class LanguageEvent {}

class GetLanguagesEvent extends LanguageEvent {
  final String supports;

  GetLanguagesEvent({required this.supports});
}
