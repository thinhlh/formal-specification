import 'package:formal_specification/base/base_controller.dart';
import 'package:formal_specification/utils/routes.dart';
import 'package:get/route_manager.dart';

class SplashController extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(Duration(seconds: 5));
    Get.toNamed(
      Routes.home,
    );
  }
}
