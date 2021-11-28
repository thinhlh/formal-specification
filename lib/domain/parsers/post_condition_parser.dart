abstract class PostConditionParser {
  static final RegExp exactMatch = RegExp(
    r'\b=\b',
    multiLine: true,
  );

  void parsingInput(String input);

  String get generateSolve;
}
