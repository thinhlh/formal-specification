import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formal_specification/base/base_screen.dart';
import 'package:formal_specification/presentation/screens/home/home_controller.dart';
import 'package:formal_specification/presentation/widgets/code_editor.dart';
import 'package:formal_specification/presentation/widgets/code_editor_controller.dart';
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
        Row(
          children: [
            TextButton(
              onPressed: () {
                Process.run('ls', ['-l']).then((ProcessResult results) {
                  print(results.stdout);
                });
              },
              child: Text('File'),
            ),
            TextButton(
              onPressed: () => {},
              child: Text('Edit'),
            ),
            TextButton(
              onPressed: codeEditorController.parsingFirstSolution,
              child: Text('Generating'),
            ),
            TextButton(
              onPressed: () => controller.showAbout(),
              child: Text('About'),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.attach_file_sharp),
              onPressed: () {},
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: Icon(Icons.folder_open_rounded),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: Icon(Icons.save),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: Icon(Icons.cut),
            ),
            IconButton(
              icon: Icon(Icons.file_copy),
              onPressed: () {},
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.undo),
              onPressed: () {},
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.redo),
              onPressed: () {},
            ),
          ],
        ),
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
                      child: Row(
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
                                          fillColor: AppColors.light,
                                          filled: true,
                                          focusColor: AppColors.light,
                                          hoverColor: AppColors.light,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimens.smallRadius),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimens.smallRadius),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimens.smallRadius),
                                          ),
                                          isDense: true,
                                          hintText: 'Class name',
                                        ),
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
                                            borderRadius: BorderRadius.circular(
                                                Dimens.smallRadius),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimens.smallRadius),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimens.smallRadius),
                                          ),
                                          isDense: true,
                                          hintText: 'Exe,bat file name',
                                        ),
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
                            onPressed: codeEditorController.buildSolution,
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
                      ),
                    ),
                    Expanded(
                      child: CodeEditor(
                        isInput: true,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: double.infinity,
                color: AppColors.background,
                width: 2,
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
}
