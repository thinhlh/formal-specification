import 'package:formal_specification/domain/argument.dart';
import 'package:formal_specification/domain/data_type.dart';
import 'package:formal_specification/domain/string_extension.dart';
import 'package:formal_specification/utils/values.dart';

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

    final result =
        parameters.map<Argument>((e) => Argument.fromString(e)).toList();
    return result;
  }

  @override
  String toString() {
    return 'Function Name: $functionName \nParameters: $parameters \nExpected Result $expectedResult';
  }

  String get generateInputFunction {
    String result = "";

    result = '''
${Values.tabs}void Input$functionName() {
$generateInputParameters
${Values.tabs}}''';
    return result;
  }

  String get generateInputParameters {
    String result = "\n";

    result += parameters.map((paramter) {
      return '''
${Values.tabs}${Values.tabs}print("Enter ${paramter.name}: ");
${Values.tabs}${Values.tabs}${paramter.inputConverterInDart}
''';
    }).join('\n');

    return result;
  }

  String generateValidationFunction(String conditions) {
    String result = "";

    result = '''
${Values.tabs}bool ${functionName}Validation() {
    
${Values.tabs}${Values.tabs}$conditions

${Values.tabs}}
  ''';
    return result;
  }

  String generateSolveFunction(String statements) {
    String result = "";

    result = '''
${Values.tabs}void ${functionName}Solve() {

${Values.tabs}${Values.tabs}final isValid=${functionName}Validation();

${Values.tabs}${Values.tabs}if( !isValid ) 
${Values.tabs}${Values.tabs}${Values.tabs}print('Thong tin nhap khong hop le');

${Values.tabs}${Values.tabs}else {
$statements
${Values.tabs}${Values.tabs}${Values.tabs}print("$functionName : \$${expectedResult.name}");
${Values.tabs}${Values.tabs}}
${Values.tabs}}
''';
    return result;
  }

  String get generateCallFunction {
    String result = "";

    result = '''
${Values.tabs}void call() {
${Values.tabs}${Values.tabs}Input${functionName}();
${Values.tabs}${Values.tabs}${functionName}Solve();
${Values.tabs}}
    ''';

    return result;
  }
}
