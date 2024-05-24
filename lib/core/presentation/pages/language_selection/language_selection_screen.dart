import 'package:flutter/material.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_type.dart';
import 'package:vachak/core/presentation/widgets/responsive.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_selection_screen_mob.dart';

class LanguageSelectionScreen extends StatefulWidget {
  final LanguageType languageType;
  const LanguageSelectionScreen({Key? key, required this.languageType})
      : super(key: key);

  @override
  State createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: LanguageSelectionScreenMob(languageType: widget.languageType),
      tablet: LanguageSelectionScreenMob(languageType: widget.languageType),
      mobile: LanguageSelectionScreenMob(languageType: widget.languageType),
    );
  }
}
