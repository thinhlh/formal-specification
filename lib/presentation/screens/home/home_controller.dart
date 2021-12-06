import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formal_specification/base/base_controller.dart';
import 'package:formal_specification/utils/dimens.dart';
import 'package:formal_specification/utils/string_utils.dart';
import 'package:formal_specification/utils/values.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends BaseController {
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController exeNameController = TextEditingController();

  final FilePicker _filePicker = FilePicker.platform;

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
        children: [
          SizedBox(height: Dimens.mediumHeightDimens),
          Text('Author: ${Values.author}'),
          Text('Release date: ${Values.releaseDate}'),
        ],
        applicationName: Values.appName,
      );
  }

  void clearComposing() {
    classNameController.clear();
    exeNameController.clear();
  }

  Future<File?> openFile() async {
    try {
      FilePickerResult? result = await _filePicker.pickFiles(
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
    if (classNameController.text.isEmpty) {
      showAlertDialog(
        title: 'Invalid file name',
        message: 'File name must not be empty',
      );
    } else {
      final String documentDirectory =
          await getApplicationDocumentsDirectory().then((value) => value.path);

      final File file = File(
        documentDirectory +
            Platform.pathSeparator +
            "${classNameController.text}.dart",
      );

      await file.writeAsString(contents);
    }
  }

  void exit() async {
    // To avoid navigator back of context menu
    await Future.delayed(Duration(milliseconds: 1));
    showAlertDialog(
      title: 'Are you sure to exit the application?',
      actions: <ElevatedButton>[
        ElevatedButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => SystemNavigator.pop(),
          child: Text('Exit'),
        ),
      ],
    );
  }
}
