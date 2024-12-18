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
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade200,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                color: const Color.fromARGB(255, 197, 164, 254),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    offset: Offset(2, 2),
                    color: Colors.black38,
                    spreadRadius: 0.2,
                  )
                ],
              ),
              child: Image.asset(
                'assets/icons/list.png',
                height: 150,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Task App',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
