import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formal_specification/base/base_controller.dart';
import 'package:formal_specification/domain/text_history.dart';
import 'package:formal_specification/utils/string_utils.dart';
import 'package:formal_specification/utils/values.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends BaseController {
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController exeNameController = TextEditingController();

  final FilePicker _filePicker = FilePicker.platform;
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

  Future<File?> openFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowCompression: false,
        allowedExtensions: ['txt'],
        dialogTitle: 'Pick an input file',
        type: FileType.custom,
      );

      if (result != null) {
        if (result.files.single.path != null) {
          File file = File(result.files.single.path!);

// This will remove the file extenstion
          classNameController.text =
              StringUtils.fileNameFromPath(file.path).split('.').first;
          return file;
        }
        return null;
      } else {
        // User canceled the picker
        return null;
      }
    } on Exception {
      print('Could not read file');
      return null;
    }
  }

  void saveFile(String contents) async {
    final String documentDirectory =
        await getApplicationDocumentsDirectory().then((value) => value.path);
    print(documentDirectory);

    final File file = File(
      documentDirectory +
          Platform.pathSeparator +
          "${classNameController.text}.dart",
    );

    await file.writeAsString(contents);

    // String? outputFile = await FilePicker.platform.saveFile(
    //   dialogTitle: 'Please select an output file: ',
    //   fileName: 'fileName.dart',
    // );

    // if (outputFile == null) {
    //   // User canceled the picker
    // }
  }
}
