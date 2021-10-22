import 'package:formal_specification/domain/argument.dart';
import 'package:formal_specification/domain/input_parser.dart';
import 'package:formal_specification/domain/string_extension.dart';

void main() {
  // runApp(const App());

  String input = "Max2So(a:R,b:R)c:R";
  print(InputParser(input: input));
}
