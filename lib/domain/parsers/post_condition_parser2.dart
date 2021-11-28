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

  /// If [resultOrCondition] is null, then this is the outer loop,
  // Else this loop is the last nested loop
  String generateLoop(
    Range range,
    String functionName, {
    String? resultOrCondition,
  }) {
    String result = "";
    bool isTT = _statements.first.substring(0, 2) == 'TT';

    String variable = _statements.first.substring(
      2,
      _statements.first.length - 2,
    );

    result = '''
bool $functionName() {
  bool isTT = $isTT;
  bool result = false;  

  for (int $variable = ${_ranges.first.value1}; i < ${_ranges.first.value2}; i++) {
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

  @override
  String get generateSolve {
    String result = "";

    return result;
  }

  String get _generateFirstLoop {
    String result = "";

    bool isTT = _statements.first.substring(0, 2) == 'TT';
    String variable = _statements.first.substring(
      2,
      _statements.first.length - 2,
    );
    result = '''    
bool isTT = $isTT;
bool result = false;  

for (int $variable = ${_ranges.first.value1}; i < ${_ranges.first.value2}; i++){
  result = ${_statements.last.replaceEquals()};

  if(isTT && result || !isTT && !result){
    break;
  }
}

return result;
    ''';
    print(result);
    return result;
  }
}
