import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:formal_specification/presentation/widgets/code_editor_controller.dart';
import 'package:formal_specification/utils/colors.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CodeEditor extends StatelessWidget {
  final bool isInput;
  final FocusNode? focusNode;
  CodeEditor({
    required this.isInput,
    this.focusNode,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CodeEditorController>(
      builder: (controller) => CodeField(
        focusNode: focusNode,
        expands: true,
        controller: isInput
            ? controller.inputCodeController
            : controller.outputCodeController,
        textStyle: TextStyle(
          fontFamily: 'SourceCode',
          // color: AppColors.onSurface,
        ),
        cursorColor: AppColors.primary,
        // background: Colors.transparent,
        // lineNumberStyle: LineNumberStyle(
        //   textStyle: TextStyle(color: AppColors.primary),
        // ),
      ),
    );
  }
}
