import 'dart:io';

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:formal_specification/base/base_controller.dart';
import 'package:formal_specification/domain/parsers/code_generator.dart';
import 'package:formal_specification/utils/cli_utils.dart';
import 'package:formal_specification/utils/colors.dart';
import 'package:highlight/languages/dart.dart';
import 'package:path_provider/path_provider.dart';

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

  void parsingFirstSolution() {
    _convertingToDart();
    // _saveToFile().then((file) => CLIUtils.executeDartFile(file.path));
  }

  void _convertingToDart() {
    /// Setting this will avoid the out of range exception
    _outputCodeController.text = _inputCodeController.text;

    _outputCodeController.text = CodeGenerator(
      value: _outputCodeController.text,
    ).toDart();
  }

  Future<File> _saveToFile() async {
    final path = await getApplicationDocumentsDirectory();
    final file = File('${path.path}/test.dart');

    return file.writeAsString(
      _outputCodeController.text,
    );
  }

  Future<void> buildSolution() async {
    parsingFirstSolution();
    _saveToFile().then((value) => CLIUtils.executeDartFile(value.path));
  }
}
