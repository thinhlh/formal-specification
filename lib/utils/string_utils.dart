import 'package:formal_specification/utils/values.dart';

class StringUtils {
  StringUtils._();

  static String conditionalWithElse(
    String condition,
    String trueStatement,
    String falseStatement,
  ) {
    final result = '''
if ($condition)
${Values.tabs}$trueStatement
else 
${Values.tabs}$falseStatement

''';

    return result;
  }

  static String conditionalWithAssignee(String condition, String assignee) {
    if (condition.isEmpty) condition = "1";

    final result = '''
${Values.tabs}${Values.tabs}${Values.tabs}if ($condition)
${formatAssignee(assignee)}  
''';

    return result;
  }

  static String trueStatement() {
    return "return true;";
  }

  static String formatAssignee(String assignee) {
    return '''
${Values.tabs}${Values.tabs}${Values.tabs}${Values.tabs}${assignee.replaceAll(RegExp(r"\bFALSE\b"), 'false').replaceAll(RegExp(r"\bTRUE\b"), 'true')};
''';
  }

  static String generateTabs(int numberOfTab) {
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < numberOfTab; i++) {
      buffer.write('\t');
    }
    return buffer.toString();
  }
}
