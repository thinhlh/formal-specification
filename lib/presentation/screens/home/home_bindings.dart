import 'package:formal_specification/presentation/screens/home/home_controller.dart';
import 'package:formal_specification/presentation/widgets/code_editor_controller.dart';
import 'package:get/instance_manager.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CodeEditorController());
  }
}
