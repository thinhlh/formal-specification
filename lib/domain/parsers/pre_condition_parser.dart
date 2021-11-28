import 'package:formal_specification/domain/string_extension.dart';
import 'package:formal_specification/utils/string_utils.dart';

class PreConditionParser {
  late final String _output;

  PreConditionParser({required String input}) {
    input = input.replaceEquals();
    if (input.isEmpty) {
      _output = StringUtils.trueStatement();
    } else
      _output = 'return $input;';
  }

  String get generateValidation => _output;
}
