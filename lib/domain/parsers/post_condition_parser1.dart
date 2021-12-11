import 'package:formal_specification/domain/parsers/post_condition_parser.dart';
import 'package:formal_specification/helper/string_extension.dart';
import 'package:formal_specification/helper/string_utils.dart';

/// This class contains a conditions map
/// It is Map<List<String>,List<String>> type which indicate a list of <Condition,Assignee> tupple
/// Each one is a string
class PostConditionParserType1 implements PostConditionParser {
  final Map<List<String>, String> _statements = {};

  /// This constructor receive an input string, which is the type of
  /// [assignee]&&[condition] || [assignee]&&[condition],
  /// it will first split the input by || to determine the number of if statements, this will also the number of number of key inside the statements
  /// Then for each statement it remove parathenses, then detect whether this is the condition, and which is the assignne
  PostConditionParserType1({required String input}) {
    parsingInput(input);
  }

  /// Split the input into if-else statements
  @override
  void parsingInput(String input) {
    for (String statement in input.split('||')) {
      _mapStatement(statement);
    }
  }

  /// Map each statement contains an assignee and zero or more than 1 conditions
  void _mapStatement(String statement) {
    String assignnee = "";
    final List<String> conditions = [];

    final List<String> assigningAndConditions = statement.split('&&');

    for (int i = 0; i < assigningAndConditions.length; i++) {
      /// Remove all the brackets

      String assigneeOrCondition = assigningAndConditions[i]
          .replaceAll(
            RegExp(r'[()]'),
            '',
          )
          .removeWhiteSpace();

      if (i == 0) {
        /// This is probably an assignment
        assignnee = assigneeOrCondition;
      } else {
        /// The rest elements is conditions => replace equals
        assigneeOrCondition = assigneeOrCondition.replaceEquals();
        conditions.add(assigneeOrCondition);
      }
    }
    _statements[conditions] = assignnee;
  }

  String _formatStatement(String condition, String assignee) {
    /// If condition is empty => Only using assignee
    if (condition.isEmpty) {
      return StringUtils.formatAssignee(assignee);
    } else {
      return StringUtils.conditionalWithAssignee(
        condition,
        '$assignee',
      );
    }
  }

  @override
  String toDart() {
    String result = "";
    _statements.forEach((conditions, assignee) {
      result += "\n";
      result += _formatStatement(conditions.join('&&'), assignee);
    });

    return result;
  }
}
