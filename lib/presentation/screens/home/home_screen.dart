import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:formal_specification/base/base_screen.dart';
import 'package:formal_specification/presentation/screens/home/home_controller.dart';

class HomeScreen extends BaseScreen<HomeController> {
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
              onPressed: () {},
              child: Text('Edit'),
            ),
            TextButton(
              onPressed: () {},
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
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: Container(
                  child: TextFormField(
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    minLines: null,
                    maxLines:
                        null, // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
                    expands: true,
                  ),
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
