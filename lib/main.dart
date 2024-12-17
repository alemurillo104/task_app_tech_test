import 'package:flutter/material.dart';
import 'package:common_dependency_module/common_dependency_module.dart';
import 'package:task_app_tech_test/firebase_options.dart';
import 'src/core/navigation/modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ModularApp(
      module: CoreModularModule(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tasks App',
      routerConfig: Modular.routerConfig,
    );
  }
}
