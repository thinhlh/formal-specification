import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formal_specification/base/base_controller.dart';
import 'package:formal_specification/presentation/widgets/code_editor_controller.dart';
import 'package:formal_specification/utils/values.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeController extends BaseController {
  void showAbout() {
    if (Get.context != null)
      showAboutDialog(
        context: Get.context!,
        applicationVersion: Values.version,
        applicationIcon: SvgPicture.asset(
          'assets/images/person.svg',
          width: 100.w,
          height: 100.h,
        ),
        applicationName: Values.appName,
      );
  }
}
