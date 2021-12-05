import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formal_specification/base/base_controller.dart';
import 'package:formal_specification/domain/text_history.dart';
import 'package:formal_specification/utils/values.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeController extends BaseController {
  final TextHistory textHistory = TextHistory();

  final RxBool undoStatus = false.obs;
  final RxBool redoStatus = false.obs;

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

  void onTextChanged(String value) {
    print('Text Change $value');

    textHistory.onTextChanged(value);

    undoStatus.value = textHistory.isUndoAble;
    redoStatus.value = textHistory.isRedoAble;
  }

  String undo() {
    if (undoStatus.value) {
      return textHistory.onUndo();
    }

    return '';
  }

  String redo() {
    if (redoStatus.value) {
      return textHistory.onRedo();
    }

    return '';
  }
}
