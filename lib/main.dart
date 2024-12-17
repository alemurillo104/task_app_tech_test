import 'package:flutter/material.dart';
import 'package:common_dependency_module/common_dependency_module.dart';
import 'src/core/navigation/modular.dart';

void main() async {
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
      title: 'Tasks App',
      routerConfig: Modular.routerConfig,
    );
  }
}
