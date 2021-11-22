import 'package:formal_specification/domain/argument.dart';
import 'package:formal_specification/domain/languages/lanaguage.dart';
import 'package:formal_specification/domain/parsers/input_parser.dart';
import 'package:formal_specification/domain/parsers/post_condition_parser.dart';
import 'package:formal_specification/domain/parsers/pre_condition_parser.dart';
import 'package:formal_specification/domain/string_extension.dart';
import 'package:formal_specification/utils/string_utils.dart';
import 'package:formal_specification/utils/values.dart';

class CodeGenerator implements Language {
  late final InputParser input;
  late final PreConditionParser preCondition;
  late final PostConditionParser postCondition;

  CodeGenerator({required String value}) {
    value = _formatInput(value);

    input = InputParser(input: _getFunctionInfoString(value));
    preCondition = PreConditionParser(input: _getPreConditionString(value));
    postCondition = PostConditionParser(input: _getPostCondtionString(value));
  }

  String _formatInput(String input) {
    return input.removeWhiteSpace().split('\n').join();
  }

  String _getFunctionInfoString(String value) {
    return value.split('pre').first.removeWhiteSpace();
  }

  String _getPreConditionString(String value) {
    return value.split('pre').last.split('post').first.removeWhiteSpace();
  }

  String _getPostCondtionString(String value) {
    return value.split('pre').last.split('post').last.removeWhiteSpace();
  }

  @override
  String toDart() {
    return '''
import 'dart:io';

void main() {
  final solve = Solve();
  solve();
}

class Solve {
$generateFields

${input.generateInputFunction}

${input.generateValidationFunction(preCondition.generateValidation)}

${input.generateSolveFunction(postCondition.generateSolve)}

${input.generateCallFunction}
}
''';
  }

  String get generateFields {
    final List<Argument> parameters = input.parameters;
    final Argument expectedResult = input.expectedResult;

    String result = "";
    result += '${Values.tabs}late ${expectedResult.toDart()}';
    parameters.forEach((element) {
      result += '\n${Values.tabs}late ${element.toDart()}';
    });

    return result;
  }
}
