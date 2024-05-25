import 'package:flutter/material.dart';
import 'package:vachak/core/domain/entities/va_language_entity.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_type.dart';
import 'package:vachak/core/presentation/utils/theme.dart';
import 'package:vachak/core/presentation/widgets/animated_tile.dart';
import 'package:vachak/core/presentation/widgets/title_widget.dart';

class LanguageSelectionScreenMob extends StatelessWidget {
  final LanguageType languageType;
  final List<VaLanguageEntity> result;

  const LanguageSelectionScreenMob(
      {super.key, required this.languageType, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_menu.jpg"),
              fit: BoxFit.fill,
              opacity: 0.5,
            ),
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(
                child: TitleWidget(
                    iconSrc: "", title: "Source", bgColor: Colors.transparent),
              ),

              // Load language entries in a list
              getSliverListForLanguage(),
            ],
          ),
        ),
      ),
    );
  }

  SliverList getSliverListForLanguage() {
    return SliverList.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        VaLanguageEntity data = result.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedClickableTile(
            bgColor: appColors.tileBgColor,
            bgColorHover: appColors.tileBgColorHover,
            textColor: appColors.tileTextColor,
            textColorHover: appColors.tileTextColorHover,
            press: () {},
            title: data.code ?? "",
            description: data.name ?? "",
          ),
        );
      },
    );
  }
}
