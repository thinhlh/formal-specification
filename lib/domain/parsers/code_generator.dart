import 'package:formal_specification/domain/argument.dart';
import 'package:formal_specification/domain/languages/lanaguage.dart';
import 'package:formal_specification/domain/parsers/input_parser.dart';
import 'package:formal_specification/domain/parsers/post_condition_parser.dart';
import 'package:formal_specification/domain/parsers/post_condition_parser1.dart';
import 'package:formal_specification/domain/parsers/post_condition_parser2.dart';
import 'package:formal_specification/domain/parsers/pre_condition_parser.dart';
import 'package:formal_specification/domain/string_extension.dart';
import 'package:formal_specification/utils/values.dart';

class CodeGenerator implements Language {
  late final InputParser input;
  late final PreConditionParser preCondition;
  late final PostConditionParser postCondition;

  CodeGenerator({required String value}) {
    value = _formatInput(value);

    input = _getFunctionInfo(value);
    preCondition = _getPreCondition(value);
    postCondition = _getPostCondtion(value);
  }

  String _formatInput(String input) {
    return input.removeWhiteSpace().split('\n').join();
  }

  InputParser _getFunctionInfo(String value) {
    return InputParser(input: value.split('pre').first.removeWhiteSpace());
  }

  PreConditionParser _getPreCondition(String value) {
    return PreConditionParser(
      input: value.split('pre').last.split('post').first.removeWhiteSpace(),
    );
  }

  PostConditionParser _getPostCondtion(String value) {
    final String output =
        value.split('pre').last.split('post').last.removeWhiteSpace();

    if (!output.contains('{')) {
      return PostConditionParserType1(input: output);
    } else {
      return PostConditionParserType2(input: output);
    }
  }

  @override
  String toDart() {
    bool isType2 = postCondition is PostConditionParserType2;
    String result = '''
import 'dart:io';

void main() {
  final solve = Solve();
  solve();
}

class Solve {
$generateFields

${input.generateInputFunction}

${input.generateValidationFunction(preCondition.generateValidation)}

${input.generateSolveFunction(isType2 ? (postCondition as PostConditionParserType2).functionCallerName : postCondition.generateSolve, isType2)}

${postCondition is PostConditionParserType2 ? postCondition.generateSolve : ''}

${input.generateCallFunction}
}
''';
    print(result);
    return result;
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
