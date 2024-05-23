import 'package:flutter/material.dart';
import 'package:vachak/core/presentation/widgets/responsive.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_selection_screen_mob.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  State createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      desktop: LanguageSelectionScreenMob(),
      tablet: LanguageSelectionScreenMob(),
      mobile: LanguageSelectionScreenMob(),
    );
  }
}
