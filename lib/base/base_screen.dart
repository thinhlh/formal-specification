import 'package:flutter/material.dart';
import 'package:formal_specification/base/base_controller.dart';
import 'package:formal_specification/utils/colors.dart';
import 'package:get/get.dart';

abstract class BaseScreen<T extends BaseController> extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  final T controller = Get.find<T>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildLoading(context),
    );
  }

  Widget buildLoading(BuildContext context) {
    return Stack(
      children: [
        buildBody(context),
        Obx(
          () => AnimatedOpacity(
            duration: controller.animationDuration,
            opacity: controller.loading.value ? 1.0 : 0.0,
            child: Visibility(
              visible: controller.loading.value,
              child: Container(
                color: AppColors.opacity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context);
}
