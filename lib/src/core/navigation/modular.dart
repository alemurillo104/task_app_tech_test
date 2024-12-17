import 'package:splash_module/splash_module.dart';
import 'package:home_module/navigation/modular.dart';
import 'package:common_dependency_module/common_dependency_module.dart';
import 'package:task_app_tech_test/src/core/navigation/navigation.dart';

class CoreModularModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      CorePath.splash,
      child: (context) => const SplashScreenPage(),
    );
    r.module(
      CorePath.home,
      module: HomeModularModule(),
      transition: TransitionType.noTransition,
    );
  }
}
