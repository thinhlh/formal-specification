import 'package:flutter/material.dart';
import 'package:formal_specification/presentation/app.dart';
import 'package:formal_specification/presentation/widgets/code_editor_controller.dart';
import 'package:get/instance_manager.dart';

void main() async {
  initDependencies();
  runApp(const App());
}

void initDependencies() {
  Get.lazyPut(() => CodeEditorController());
}
