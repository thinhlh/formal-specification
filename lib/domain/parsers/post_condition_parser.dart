import 'package:formal_specification/domain/languages/lanaguage.dart';

abstract class PostConditionParser implements Language {
  static final RegExp exactMatch = RegExp(
    r'\b=\b',
    multiLine: true,
  );

  void parsingInput(String input);
}
