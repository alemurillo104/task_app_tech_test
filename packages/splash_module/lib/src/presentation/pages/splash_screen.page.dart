import 'package:flutter/material.dart';
import 'package:common_dependency_module/common_dependency_module.dart';
import '../../../navigation/navigation.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), _goToHomePage);
    super.initState();
  }

  _goToHomePage() {
    logger.d('going to home page');
    Modular.to.navigate(SplashDestination.home);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash page',
        ),
      ),
    );
  }
}
