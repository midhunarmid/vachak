import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:vachak/core/domain/entities/va_language_entity.dart';
import 'package:vachak/core/presentation/blocs/language/language_bloc_bloc.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_type.dart';
import 'package:vachak/core/presentation/utils/constants.dart';
import 'package:vachak/core/presentation/utils/theme.dart';
import 'package:vachak/core/presentation/utils/widget_helper.dart';
import 'package:vachak/core/presentation/widgets/animated_tile.dart';
import 'package:vachak/core/presentation/widgets/title_widget.dart';
import 'package:vachak/core/presentation/widgets/web_optimised_widget.dart';

class LanguageSelectionScreenMob extends StatefulWidget {
  final LanguageType languageType;
  final String supports;
  const LanguageSelectionScreenMob(
      {Key? key, required this.languageType, this.supports = ""})
      : super(key: key);

  @override
  State createState() => _LanguageSelectionScreenMobState();
}

class _LanguageSelectionScreenMobState
    extends State<LanguageSelectionScreenMob> {
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocListener(
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
              return Center(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: TitleWidget(
                          iconSrc: "",
                          title: "Source Language",
                          bgColor: appColors.appBarBg),
                    ),

                    // Load language entries in a list
                    getSliverListForLanguage(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  SliverList getSliverListForLanguage() {
    return SliverList.builder(
      itemCount: _result.length,
      itemBuilder: (context, index) {
        VaLanguageEntity data = _result.elementAt(index);
        return AnimatedClickableTile(
          bgColor: appColors.tileBgColor,
          bgColorHover: appColors.tileBgColorHover,
          textColor: appColors.tileTextColor,
          textColorHover: appColors.tileTextColorHover,
          press: () {},
          title: data.code ?? "",
        );
      },
    );
  }
}
