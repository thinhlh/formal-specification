import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final loading = false.obs;
  Duration get animationDuration => const Duration(milliseconds: 500);

  void showLoading(bool show) {
    loading.value = show;
  }

  void showAlertDialog({
    String? title,
    String? message,
    List<Widget>? actions,
  }) {
    Get.dialog(
      AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        actions: actions,
        title: title != null
            ? Text(
                title,
                textAlign: TextAlign.center,
              )
            : null,
        content: message != null ? Text(message) : null,
      ),
    );
  }
}
