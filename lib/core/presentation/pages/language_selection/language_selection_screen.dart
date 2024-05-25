import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:vachak/core/domain/entities/va_language_entity.dart';
import 'package:vachak/core/presentation/blocs/language/language_bloc.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_selection_screen_mob.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_selection_screen_tab.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_selection_screen_web.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_type.dart';
import 'package:vachak/core/presentation/utils/constants.dart';
import 'package:vachak/core/presentation/utils/theme.dart';
import 'package:vachak/core/presentation/utils/widget_helper.dart';
import 'package:vachak/core/presentation/widgets/responsive.dart';
import 'package:vachak/core/presentation/widgets/web_optimised_widget.dart';

class LanguageSelectionScreen extends StatefulWidget {
  final LanguageType languageType;
  final String supports;
  const LanguageSelectionScreen(
      {Key? key, required this.languageType, this.supports = ""})
      : super(key: key);

  @override
  State createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final LanguageBloc _bloc = LanguageBloc();
  ProgressDialog? _pr;

  final List<VaLanguageEntity> _result = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetLanguagesEvent(supports: widget.supports));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: _bloc,
        listener: (ctx, state) {
          appLogger.i(state);

          if (_pr?.isShowing() ?? false) {
            _pr?.hide();
          }
          if (state is LanguageLoadingState) {
            _pr = ProgressDialog(
              context,
              type: ProgressDialogType.normal,
              isDismissible: false,
            );
            _pr?.style(
              backgroundColor: appColors.screenBg,
              padding: WebOptimisedWidget.getWebOptimisedHorizonatalPadding(),
              message: state.loadingInfo.message,
              widgetAboveTheDialog: Text(
                state.loadingInfo.title,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              progressWidget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoadingIndicator(
                  indicatorType: Indicator.ballScaleMultiple,
                  colors: appColors.rainbowColors,
                  strokeWidth: 2,
                  backgroundColor: appColors.screenBg,
                  pathBackgroundColor: appColors.screenBg,
                ),
              ),
              progressTextStyle: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontWeight: FontWeight.w400),
              messageTextStyle: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontWeight: FontWeight.w400),
            );
            _pr?.show();
          } else if (state is LanguageErrorState) {
            showSingleButtonAlertDialog(
                context: context, title: state.title, message: state.message);
          } else if (state is LanguageSuccessState) {
            _result.addAll(state.languages);
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            return Responsive(
              desktop: LanguageSelectionScreenWeb(
                languageType: widget.languageType,
                result: _result,
              ),
              tablet: LanguageSelectionScreenTab(
                languageType: widget.languageType,
                result: _result,
              ),
              mobile: LanguageSelectionScreenMob(
                languageType: widget.languageType,
                result: _result,
              ),
            );
          },
        ),
      ),
    );
  }
}
