import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart' as shell;

class CLIUtils {
  CLIUtils._();

  static Future<String> get basePath =>
      getApplicationDocumentsDirectory().then((value) => value.path);

  static void executeDartFile(String path) async {
    final String command = await (Platform.isMacOS
        ? _dartRunCommandOnMac(path)
        : _dartRunCommandOnWindow(path));

    shell.run(command);
  }

  /// PATH include .extension
  static Future<String> _dartRunCommandOnWindow(String path) async {
    final String finalPath = await basePath + Platform.pathSeparator + path;
    return "start cmd.exe /c dart run $finalPath.dart";
  }

  /// PATH include .extension
  static Future<String> _dartRunCommandOnMac(String path) async {
    final String finalPath = await basePath + Platform.pathSeparator + path;

    return 'osascript -e \'tell app "Terminal" to do script "dart run $finalPath.dart"\'';
  }

  /// PATH and exe name do not include  .extension
  static Future<File> writeExecutableDartFile(
    String exeName,
    String dartFilePath,
  ) async {
    // Base Path is also the path of exe files
    final String codePath =
        await basePath + Platform.pathSeparator + dartFilePath;
    final String exePath =
        await basePath + Platform.pathSeparator + exeName + '.sh';
    print(exePath);

    return File(exePath).writeAsString("dart run '$codePath.dart");
  }
}
