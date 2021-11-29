import 'package:dartz/dartz.dart';
import 'package:formal_specification/domain/parsers/post_condition_parser.dart';
import 'package:formal_specification/domain/parsers/range.dart';
import 'package:formal_specification/domain/string_extension.dart';

/// This class is used for post condition parser with 2nd types
/// They will generally have 2 instances: 1 loop and 2 loops
/// E.g: kq = (VM i TH {1..n-1}.a(i) <= a(i+1))
/// Or kq = (TT i TH {1..n-1}. TT j TH {i+1..n}.a(i) <= a(j))
/// The algorithms for this is to parsing the post condition to following snippet
///
/// bool isTT=false;
/// bool result=false;
/// for (int i=1;i<n-1;i++) {
///   result=a[i]<=a[i]+1;
///   if(TT&&result||VM&&!result){
///     break;
///   }
/// }
///
/// return result;
///
class PostConditionParserType2 implements PostConditionParser {
  static const String rangeRegex = r"{([\s\S]*?)}";

  /// The last statements is always a condition
  final List<String> _statements = [];

  /// The number of range is the number of _statements - 1
  /// The number of ranges also the number of loop
  final List<Tuple2<String, String>> _ranges = [];

  PostConditionParserType2({required String input}) {
    parsingInput(input);
  }
  @override
  void parsingInput(String input) {
    // RegExp(rangeRegex).allMatches(input).forEach((element) {
    //   print(element.group(0));
    // });

    _splitToStatements(_removeFirstAssignment(input));
    _retrieveRanges(input);
  }

  /// Remove the kq= in the post condition and it's parantheses
  String _removeFirstAssignment(String input) {
    // input = input.removeWhiteSpace();

    late int firstParantheseIndex;
    for (int i = 0; i < input.list.length; i++) {
      if (input.list[i] == '(') {
        firstParantheseIndex = i;
        break;
      }
    }
    return input.substring(firstParantheseIndex + 1, input.length - 1);
  }

  // Each statement either a loop information TT i TH {1..n-1} or condition
  void _splitToStatements(String input) {
    _statements.addAll(
      input
          .split(
            RegExp(
              rangeRegex,
              dotAll: true,
              multiLine: true,
              caseSensitive: false,
            ),
          )
          .map((e) => e.startsWith(".") ? e.substring(1) : e),
    );
  }

  void _retrieveRanges(String input) {
    RegExp(rangeRegex).allMatches(input).forEach(
      (element) {
        String value = element.group(0) ?? "";
        if (value.startsWith('{')) {
          value = value.substring(1, value.length - 1);

          _ranges.add(Tuple2(value.split('..').first, value.split('..').last));
        }
      },
    );
  }

  // Retrieve variable from statement
  String _retrieveVariable(String statement) {
    return statement.substring(
      2,
      statement.length - 2,
    );
  }

  bool _retrieveIsTT(String statement) {
    return _statements.first.substring(0, 2) == 'TT';
  }

  /// If [resultOrCondition] is null, then this is the outer loop,
  // Else this loop is the last nested loop
  String generateLoop({
    required Tuple2 range,
    required bool isTT,
    required String variable,
    required String functionName,
    String? resultOrCondition,
  }) {
    String result = "";

    result = '''
bool $functionName() {
  bool isTT = $isTT;
  bool result = false;  

  for (int $variable = ${range.value1}; i < ${range.value2}; i++) {
    result = $resultOrCondition;

    if(isTT && result || !isTT && !result) {
      break;
    }
  }
  return result;
}
    ''';

    return result;
  }

  /// This method is used to retrieve function caller name
  /// For e.g 1loop => generateLoop1
  /// For e.g 2loop => this will also return generateLoop1
  String get functionCallerName {
    return 'generateLoop${_statements.length > 1 ? 1 : 0}()';
  }

  @override
  String get generateSolve {
    String result = "";
    for (int i = 0; i < _ranges.length; i++) {
      result += generateLoop(
        range: _ranges[i],
        functionName: 'generateLoop${i + 1}',
        variable: _retrieveVariable(_statements[i]),
        isTT: _retrieveIsTT(_statements[i]),
        resultOrCondition: i == _ranges.length - 1
            ? _statements.last
                .replaceEquals()
                .replaceAll('(', '[')
                .replaceAll(')', ']')
            : 'generateLoop${i + 2}()',
      );
    }
    return result;
  }
}
