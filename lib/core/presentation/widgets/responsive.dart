import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/theme_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: desktop,
          );
        } else if (constraints.maxWidth >= 650) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/theme_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: tablet,
          );
        } else {
          return mobile;
        }
      },
    );
  }

  static int getResponsiveCount(BuildContext context,
      {int desktop = 3,
      int tab = 2,
      int mobile = 1,
      shouldEnforceMobileUI = false}) {
    if (shouldEnforceMobileUI) {
      return mobile;
    } else if (Responsive.isDesktop(context)) {
      return desktop;
    } else if (Responsive.isTablet(context)) {
      return tab;
    } else {
      return mobile;
    }
  }

  static double getResponsiveCountAsDouble(BuildContext context,
      {double desktop = 3, double tab = 2, double mobile = 1}) {
    if (Responsive.isDesktop(context)) {
      return desktop;
    } else if (Responsive.isTablet(context)) {
      return tab;
    } else {
      return mobile;
    }
  }
}
