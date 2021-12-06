import 'dart:io';

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:formal_specification/base/base_controller.dart';
import 'package:formal_specification/domain/parsers/code_generator.dart';
import 'package:formal_specification/data/text_history.dart';
import 'package:formal_specification/utils/cli_utils.dart';
import 'package:formal_specification/utils/colors.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/dart.dart';

class CodeEditorController extends BaseController {
  final TextHistory textHistory = TextHistory();
  final RxBool undoStatus = false.obs;
  final RxBool redoStatus = false.obs;

  late CodeController _inputCodeController;
  late CodeController _outputCodeController;
  final FocusNode inputFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    _initCodeController();
  }

  void _initCodeController() {
    // Instantiate the CodeController
    _inputCodeController = CodeController(
      onChange: onTextChange,
      params: EditorParams(tabSpaces: 4),
      language: dart,
      theme: monokaiSublimeTheme,
      stringMap: {
        "pre": TextStyle(fontFamily: 'SourceCode', color: AppColors.secondary),
        "post": TextStyle(fontFamily: 'SourceCode', color: AppColors.secondary),
        "Z": TextStyle(fontFamily: 'SourceCode', color: AppColors.secondary),
        "N": TextStyle(fontFamily: 'SourceCode', color: AppColors.secondary),
        "R": TextStyle(fontFamily: 'SourceCode', color: AppColors.secondary),
        "B": TextStyle(fontFamily: 'SourceCode', color: AppColors.secondary),
        "char\*":
            TextStyle(fontFamily: 'SourceCode', color: AppColors.secondary),
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

  void generatingSolution() {
    _convertingToDart();
  }

  void _convertingToDart() {
    /// Setting this will avoid the out of range exception
    _outputCodeController.value =
        TextEditingValue(text: _inputCodeController.text);

    if (outputText.isEmpty) {
      showAlertDialog(
        title: 'Invalid input!',
        message: 'Content cannot be empty.',
      );
    }

    _outputCodeController.value = TextEditingValue(
      text: CodeGenerator(
        value: outputText,
      ).toDart(),
    );
  }

  Future<File> _saveToFile(String filename) async {
    final file = File(
      await CLIUtils.basePath + Platform.pathSeparator + '$filename.dart',
    );

    return file.writeAsString(
      _outputCodeController.text,
    );
  }

  Future<void> buildSolution(String codeFileName, String exeFileName) async {
    generatingSolution();
    if (codeFileName.isEmpty)
      showAlertDialog(
        title: 'Invalid file name',
        message: 'File name must not be empty',
      );
    else
      _saveToFile(codeFileName)
          .then((value) => CLIUtils.executeDartFile('$codeFileName.dart'));

    if (exeFileName.isNotEmpty) {
      CLIUtils.writeExecutableDartFile(exeFileName, '$codeFileName.dart');
    }
  }

  void clearComposing() {
    _inputCodeController.clear();
    _outputCodeController.clear();
    textHistory.clear();
    _updateUndoAndRedoAbility();
  }

  void undo() {
    if (undoStatus.value) {
      inputCodeController.clear();
      final text = textHistory.onUndo();
      inputCodeController.value = TextEditingValue(text: text);
      _updateUndoAndRedoAbility();
    }
  }

  void redo() {
    if (redoStatus.value) {
      inputCodeController.clear();
      inputCodeController.value = TextEditingValue(text: textHistory.onRedo());
      _updateUndoAndRedoAbility();
    }
  }

  void cut() {
    Get.focusScope?.requestFocus(inputFocusNode);

    _inputCodeController.selection = textHistory.inputSelection;

    _inputCodeController.removeSelection();
  }

  void copy() {
    Get.focusScope?.requestFocus(inputFocusNode);

    _inputCodeController.selection = textHistory.inputSelection;

    final String selectedText =
        _inputCodeController.selection.textInside(_inputCodeController.text);

    Clipboard.setData(ClipboardData(text: selectedText));
    Get.snackbar(
      'Text copied',
      selectedText,
      animationDuration: Duration(milliseconds: 1000),
      duration: Duration(seconds: 1),
    );
  }

  void paste() async {
    Get.focusScope?.requestFocus(inputFocusNode);

    final value = await Clipboard.getData('text/plain');
    _inputCodeController.selection = textHistory.inputSelection;

    if (value == null || value.text == null) return;
    _inputCodeController.insertStr(value.text!);
  }

  void onTextChange(String value) {
    textHistory.onTextChanged(inputText, _inputCodeController.selection);

    _updateUndoAndRedoAbility();
  }

  void _updateUndoAndRedoAbility() {
    undoStatus.value = textHistory.isUndoAble;
    redoStatus.value = textHistory.isRedoAble;
  }
}
