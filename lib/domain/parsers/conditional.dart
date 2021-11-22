import 'package:formal_specification/domain/operator.dart';
import 'package:formal_specification/domain/string_extension.dart';

/// This class is used to indicate the condition between 2 variables
///
/// For e.g: [value1] >= [value2] where ***>=*** is the [Operator] object
class Conditional {
  late final String value1;
  late final String value2;
  late final Operator operator;

  /// This is a constructor with [value1] [operator] [value2] format
  Conditional(String value) {
    final afterSplit = value.split(RegExp(r'\W+'));
    afterSplit.removeWhere((element) => element == '(' || element == ')');
    afterSplit.removeWhere((element) => element.isEmpty);

    value1 = afterSplit.first;
    value2 = afterSplit.last;
    operator = Operator.Add;
  }
}
