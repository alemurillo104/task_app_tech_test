import 'package:common_dependency_module/common_dependency_module.dart';
import '../src/presentation/pages/home.page.dart';

class HomeModularModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
