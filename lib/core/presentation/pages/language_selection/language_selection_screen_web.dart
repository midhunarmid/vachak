import 'package:flutter/material.dart';
import 'package:vachak/core/domain/entities/va_language_entity.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_selection_screen_mob.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_type.dart';

class LanguageSelectionScreenWeb extends StatelessWidget {
  final LanguageType languageType;
  final List<VaLanguageEntity> result;

  const LanguageSelectionScreenWeb(
      {super.key, required this.languageType, required this.result});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(),
        ),
        SizedBox(
          width: 640,
          child: LanguageSelectionScreenMob(
            languageType: languageType,
            result: result,
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(),
        ),
      ],
    );
  }
}
