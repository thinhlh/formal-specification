import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:formal_specification/base/base_controller.dart';
import 'package:formal_specification/utils/colors.dart';
import 'package:highlight/languages/dart.dart';

class CodeEditorController extends BaseController {
  late final CodeController _inputCodeController;
  late final CodeController _outputCodeController;
  @override
  void onInit() {
    super.onInit();
    _initCodeController();
  }

  void _initCodeController() {
    // Instantiate the CodeController
    _inputCodeController = CodeController(
      params: EditorParams(tabSpaces: 4),
      language: dart,
      theme: monokaiSublimeTheme,
      stringMap: {
        "pre": TextStyle(fontFamily: 'SourceCode', color: AppColors.secondary
            // color: AppColors.onSurface,
            ),
        "post": TextStyle(fontFamily: 'SourceCode', color: AppColors.secondary
            // color: AppColors.onSurface,
            ),
      },
    );

    _outputCodeController = CodeController(
      params: EditorParams(tabSpaces: 4),
      language: dart,
      theme: monokaiSublimeTheme,
      stringMap: {
        "pre": TextStyle(fontFamily: 'SourceCode', color: AppColors.secondary
            // color: AppColors.onSurface,
            ),
        "post": TextStyle(fontFamily: 'SourceCode', color: AppColors.secondary
            // color: AppColors.onSurface,
            ),
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    _inputCodeController.dispose();
    _outputCodeController.dispose();
  }

  CodeController get inputCodeController => _inputCodeController;
  CodeController get outputCodeController => _outputCodeController;

  String get inputText => _inputCodeController.text;
  String get outputText => _outputCodeController.text;
}
