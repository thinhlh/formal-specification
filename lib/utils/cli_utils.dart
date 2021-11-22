import 'package:process_run/shell.dart' as shell;

class CLIUtils {
  CLIUtils._();

  static void executeDartFile(String path) {
    final String command =
        "osascript -e 'tell app \"Terminal\" to do script \"dart run $path\"'";
    String command1 = "";
    command1 +=
        'osascript -e \'tell app "Terminal" to do script "dart run $path"\'';
    // command1 += "";

    shell.run(command1);
  }
}
