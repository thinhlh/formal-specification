import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formal_specification/base/base_screen.dart';
import 'package:formal_specification/presentation/screens/home/home_controller.dart';
import 'package:formal_specification/presentation/widgets/code_editor.dart';
import 'package:formal_specification/presentation/widgets/code_editor_controller.dart';
import 'package:formal_specification/presentation/widgets/custom_icon_button.dart';
import 'package:formal_specification/utils/colors.dart';
import 'package:formal_specification/utils/dimens.dart';
import 'package:formal_specification/utils/style.dart';
import 'package:get/get.dart';

class HomeScreen extends BaseScreen<HomeController> {
  final CodeEditorController codeEditorController =
      Get.find<CodeEditorController>();

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildTextMenu(),
        buildIconButtons(),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimens.mediumHeightDimens,
                        horizontal: Dimens.extraLargeHeightDimens,
                      ),
                      child: buildSolutionInfoWidgets(),
                    ),
                    Expanded(
                      child: CodeEditor(
                        isInput: true,
                        focusNode: codeEditorController.inputFocusNode,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: double.infinity,
                color: AppColors.background,
                width: Dimens.mediumWidthDimens,
              ),
              Expanded(
                child: CodeEditor(
                  isInput: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTextMenu() {
    return Row(
      children: [
        SizedBox(width: Dimens.smallWidthDimens),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.mediumWidthDimens),
          child: PopupMenuButton(
            tooltip: 'Show file menu',
            itemBuilder: (_) => <PopupMenuEntry<dynamic>>[
              PopupMenuItem<dynamic>(
                child: Text('New test case'),
                onTap: clearComposing,
              ),
              PopupMenuItem<dynamic>(
                child: Text('Open file'),
                onTap: openFile,
              ),
              PopupMenuItem<dynamic>(
                child: Text('Save file'),
                onTap: () =>
                    controller.saveFile(codeEditorController.outputText),
              ),
              PopupMenuItem<dynamic>(
                child: Text('Exit'),
                onTap: controller.exit,
              ),
            ],
            child: Text(
              'File',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.mediumWidthDimens),
          child: PopupMenuButton(
            tooltip: 'Show edit menu',
            itemBuilder: (_) => <PopupMenuEntry<dynamic>>[
              PopupMenuItem<dynamic>(
                child: Text('Copy'),
                onTap: codeEditorController.copy,
              ),
              PopupMenuItem<dynamic>(
                child: Text('Paste'),
                onTap: codeEditorController.paste,
              ),
              PopupMenuItem<dynamic>(
                child: Text('Cut'),
                onTap: codeEditorController.cut,
              ),
              PopupMenuItem<dynamic>(
                child: Text('Undo'),
                onTap: codeEditorController.undo,
              ),
              PopupMenuItem<dynamic>(
                child: Text('Redo'),
                onTap: codeEditorController.redo,
              ),
            ],
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
        Tooltip(
          message: 'Generate solution',
          child: TextButton(
            onPressed: codeEditorController.generatingSolution,
            child: Text('Generating'),
          ),
        ),
        Tooltip(
          message: 'About Us',
          child: TextButton(
            onPressed: () => controller.showAbout(),
            child: Text('About'),
          ),
        ),
      ],
    );
  }

  Widget buildIconButtons() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.smallWidthDimens),
      child: Row(
        children: [
          CustomIconButton(
            icon: Icons.post_add,
            onPressed: clearComposing,
            tooltip: 'New test case',
          ),
          CustomIconButton(
            onPressed: openFile,
            icon: Icons.folder_open_rounded,
            tooltip: 'Open file',
            iconColor: AppColors.yellowPallete,
          ),
          CustomIconButton(
            onPressed: () =>
                controller.saveFile(codeEditorController.outputText),
            icon: Icons.save,
            tooltip: 'Save file',
            iconColor: AppColors.onSurface,
          ),
          CustomIconButton(
            onPressed: codeEditorController.cut,
            icon: Icons.cut,
            tooltip: 'Cut',
            iconColor: AppColors.secondary,
          ),
          CustomIconButton(
            icon: Icons.file_copy,
            onPressed: codeEditorController.copy,
            tooltip: 'Copy',
            iconColor: AppColors.bluePallete,
          ),
          CustomIconButton(
            icon: Icons.paste,
            onPressed: codeEditorController.paste,
            tooltip: 'Paste',
            iconColor: AppColors.primary,
          ),
          Obx(
            () => CustomIconButton(
              icon: Icons.undo,
              iconColor: codeEditorController.undoStatus.value
                  ? AppColors.onSurface
                  : AppColors.disabledColor,
              onPressed: codeEditorController.undo,
              tooltip: 'Undo',
            ),
          ),
          Obx(
            () => CustomIconButton(
              icon: Icons.redo,
              iconColor: codeEditorController.redoStatus.value
                  ? AppColors.onSurface
                  : AppColors.disabledColor,
              onPressed: codeEditorController.redo,
              tooltip: 'Redo',
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSolutionInfoWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Class name'),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        suffixText: '.dart',
                        fillColor: AppColors.light,
                        filled: true,
                        focusColor: AppColors.light,
                        hoverColor: AppColors.light,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimens.smallRadius),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimens.smallRadius),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimens.smallRadius),
                        ),
                        isDense: true,
                        hintText: 'Class name',
                      ),
                      controller: controller.classNameController,
                      style: Get.textTheme.bodyText1,
                    ),
                  )
                ],
              ),
              SizedBox(height: Dimens.mediumHeightDimens),
              Row(
                children: [
                  Expanded(
                    child: Text('Executable file name'),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: AppColors.light,
                        filled: true,
                        focusColor: AppColors.light,
                        hoverColor: AppColors.light,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimens.smallRadius),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimens.smallRadius),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimens.smallRadius),
                        ),
                        isDense: true,
                        hintText: 'Exe,bat file name',
                        suffixText: '.sh',
                      ),
                      controller: controller.exeNameController,
                      style: Get.textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: Dimens.extraLargeWidthDimens),
        ElevatedButton(
          onPressed: () => codeEditorController.buildSolution(
            controller.classNameController.text,
            controller.exeNameController.text,
          ),
          child: Text(
            'Build Solution',
            style: TextStyle(
              color: AppColors.onSurface,
              fontWeight: AppStyle.BOLD,
            ),
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(5),
            backgroundColor: MaterialStateProperty.all(
              AppColors.tetiaryColor,
            ),
          ),
        )
      ],
    );
  }

  void clearComposing() async {
    controller.clearComposing();
    codeEditorController.clearComposing();
  }

  void openFile() async {
    final File? file = await controller.openFile();
    if (file == null) return;

    codeEditorController.inputCodeController.text = await file.readAsString();
  }
}
