import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vachak/core/data/models/plain_response_model.dart';
import 'package:vachak/core/domain/entities/va_language_entity.dart';
import 'package:vachak/core/domain/usecases/language.dart';
import 'package:vachak/core/presentation/utils/constants.dart';
import 'package:vachak/core/presentation/utils/message_generator.dart';
import 'package:vachak/core/presentation/utils/my_app_exception.dart';
import 'package:vachak/main.dart';

part 'language_bloc_event.dart';
part 'language_bloc_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageBlocInitial()) {
    on<LanguageEvent>((event, emit) async {
      try {
        appLogger.i(event);
        if (event is GetLanguagesEvent) {
          emit.call(
            LanguageLoadingState(
              LoadingInfo(
                icon: LoadingIconEnum.fetching,
                title:
                    MessageGenerator.getMessage("LOAD_SOURCE_LANGUAGE_TITLE"),
                message:
                    MessageGenerator.getMessage("LOAD_SOURCE_LANGUAGE_DESC"),
              ),
            ),
          );

          LanguageSelectionUseCase languageSelectionUseCase =
              GetIt.instance<LanguageSelectionUseCase>();
          List<VaLanguageEntity> languages =
              await languageSelectionUseCase.getLanguages("ml");
          MyApp.debugPrint(languages.toString());

          await delayedEmit(emit, LanguageSuccessState(languages: languages));
        }
      } on MyAppException catch (ae) {
        appLogger.e(ae);
        await delayedEmit(
          emit,
          LanguageErrorState(
            MessageGenerator.getMessage(ae.title),
            MessageGenerator.getMessage(ae.message),
            StatusInfoIconEnum.error,
          ),
        );
      } catch (e) {
        appLogger.e(e);
        await delayedEmit(
          emit,
          LanguageErrorState(
            MessageGenerator.getMessage("un-expected-error"),
            MessageGenerator.getMessage("un-expected-error-message"),
            StatusInfoIconEnum.error,
          ),
        );
      }
    });
  }

  Future<void> delayedEmit(
      Emitter<LanguageState> emitter, LanguageState state) async {
    await Future.delayed(const Duration(milliseconds: 500));
    emitter.call(state);
  }
}
