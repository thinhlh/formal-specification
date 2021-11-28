import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:formal_specification/base/base_screen.dart';
import 'package:formal_specification/domain/parsers/code_generator.dart';
import 'package:formal_specification/presentation/screens/home/home_controller.dart';
import 'package:formal_specification/presentation/widgets/code_editor.dart';
import 'package:formal_specification/presentation/widgets/code_editor_controller.dart';
import 'package:formal_specification/utils/cli_utils.dart';
import 'package:formal_specification/utils/colors.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

class HomeScreen extends BaseScreen<HomeController> {
  Process? openTerminal;

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
        Expanded(
          child: Row(
            children: [
              Expanded(
                // child: TextFormField(
                //   controller: controller.inputController,
                //   expands: true,
                //   maxLines: null,
                //   keyboardType: TextInputType.multiline,
                // ),
                child: CodeEditor(
                  isInput: true,
                ),
              ),
              Container(
                height: double.infinity,
                color: AppColors.background,
                width: 2,
              ),
              Expanded(
                // child: Container(
                //   child: TextFormField(
                //     controller: controller.outputController,
                //     textInputAction: TextInputAction.newline,
                //     keyboardType: TextInputType.multiline,
                //     minLines: null,
                //     maxLines:
                //         null, // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
                //     expands: true,
                //   ),
                // ),
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

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var code = '''main() {
  print("Hello, World!");
}
''';

    return HighlightView(
      // The original code to be highlighted
      code,

      // Specify language
      // It is recommended to give it a value for performance
      language: 'dart',

      // Specify highlight theme
      // All available themes are listed in `themes` folder
      theme: githubTheme,

      // Specify padding
      padding: EdgeInsets.all(12),

      // Specify text style
      textStyle: TextStyle(
        fontFamily: 'My awesome monospace font',
        fontSize: 16,
      ),
    );
  }
}
