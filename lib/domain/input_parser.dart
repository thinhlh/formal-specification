import 'package:formal_specification/domain/argument.dart';
import 'package:formal_specification/domain/string_extension.dart';

class InputParser {
  late final String functionName;
  late final Argument expectedResult;
  late final List<Argument> parameters;
  InputParser({required String input}) {
    input = input.removeWhiteSpace();

    functionName = _functionName(input);

    final String expResultStr = _expectedResult(input);
    expectedResult = _parameters(expResultStr).first;

    parameters = _parameters(
      input.substring(
        functionName.length + 1,
        input.length - (expResultStr.length + 1),
      ),
    );
  }

  String _functionName(String input) {
    String result = '';
    for (String char in input.list) {
      if (char != '(')
        result += char;
      else {
        break;
      }
    }
    return result;
  }

  String _expectedResult(String input) {
    String result = '';
    for (String char in input.reversed.list) {
      if (char != ')')
        result += char;
      else
        break;
    }
    return result.reversed;
  }

  List<Argument> _parameters(String input) {
    List<String> parameters = input.split(',');
    if (input.isEmpty) return List.empty();
    return parameters.map<Argument>((e) => Argument.fromString(e)).toList();
  }

  @override
  String toString() {
    return 'Function Name: $functionName \n Parameters: $parameters \n Expected Result $expectedResult';
  }
}
