import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vachak/core/data/models/auth_user_model.dart';
import 'package:vachak/core/data/models/plain_response_model.dart';
import 'package:vachak/core/domain/entities/va_language_entity.dart';
import 'package:vachak/core/domain/usecases/authentication.dart';
import 'package:vachak/core/domain/usecases/language.dart';
import 'package:vachak/core/presentation/utils/constants.dart';
import 'package:vachak/core/presentation/utils/message_generator.dart';
import 'package:vachak/core/presentation/utils/my_app_exception.dart';
import 'package:get_it/get_it.dart';
import 'package:vachak/main.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      try {
        appLogger.i(event);
        if (event is AuthSignInEvent) {
          emit.call(
            LoadingState(
              LoadingInfo(
                icon: LoadingIconEnum.submitting,
                title: MessageGenerator.getLabel("Signing In"),
                message: MessageGenerator.getMessage(
                    "Please wait while we sign in to the system."),
              ),
            ),
          );

          LanguageSelectionUseCase languageSelectionUseCase =
              GetIt.instance<LanguageSelectionUseCase>();
          List<VaLanguageEntity> languages =
              await languageSelectionUseCase.getLanguages("ml");
          MyApp.debugPrint(languages.toString());

          AuthenticationUseCase getUserProfileUseCase =
              GetIt.instance<AuthenticationUseCase>();

          AuthUserModel authUserModel = await getUserProfileUseCase
              .authenticateUser(event.email, event.password);

          await delayedEmit(emit, AuthSignedInState(authUserModel));
        }
      } on MyAppException catch (ae) {
        appLogger.e(ae);
        await delayedEmit(
          emit,
          AuthErrorState(
            MessageGenerator.getMessage(ae.title),
            MessageGenerator.getMessage(ae.message),
            StatusInfoIconEnum.error,
          ),
        );
      } catch (e) {
        appLogger.e(e);
        await delayedEmit(
          emit,
          AuthErrorState(
            MessageGenerator.getMessage("un-expected-error"),
            MessageGenerator.getMessage("un-expected-error-message"),
            StatusInfoIconEnum.error,
          ),
        );
      }
    });
  }

  Future<void> delayedEmit(
      Emitter<AuthenticationState> emitter, AuthenticationState state) async {
    await Future.delayed(const Duration(milliseconds: 500));
    emitter.call(state);
  }
}
