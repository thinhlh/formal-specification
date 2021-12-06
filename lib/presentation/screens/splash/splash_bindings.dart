import 'package:formal_specification/presentation/screens/splash/splash_controller.dart';
import 'package:get/instance_manager.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
