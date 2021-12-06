import 'package:formal_specification/domain/entity/data_type.dart';
import 'package:formal_specification/domain/languages/lanaguage.dart';
import 'package:formal_specification/utils/string_extension.dart';
import 'package:formal_specification/utils/values.dart';

class Argument implements Language {
  final String name;
  final DataType dataType;

  Argument({
    required this.name,
    required this.dataType,
  });

  /// [Name] : [DataType]
  factory Argument.fromString(String input) {
    final List<String> values = input.split(':');

    return Argument(
      name: values.first,
      dataType: values.last.toDataType(),
    );
  }

  @override
  String toString() {
    return 'Argument $name: $dataType';
  }

  @override
  String toDart() {
    return '${dataType.toDart()} $name = $_defaultValue;';
  }

  String get _defaultValue {
    switch (dataType) {
      case DataType.NaturalNumber:
      case DataType.Integer:
      case DataType.Real:
        return '0';
      case DataType.Boolean:
        return 'false';
      case DataType.String:
        return '""';
      case DataType.NaturalNumberArray:
      case DataType.RealArray:
      case DataType.IntegerArray:
        return '[]';
      default:
        return '0';
    }
  }

  bool get isArrayType {
    return dataType == DataType.NaturalNumberArray ||
        dataType == DataType.RealArray ||
        dataType == DataType.IntegerArray;
  }

  /// Convert a string from CLI to appropriate type in Dart
  /// Variable for number of element is the variable to evaluate the number of element inside the array
  /// For e.g(a:R*,n:N) => this is n
  String inputConverterInDart({String? variableForNumberOfElement}) {
    switch (dataType) {
      case DataType.NaturalNumber:

      case DataType.Integer:
        return '$name = int.tryParse(stdin.readLineSync() ?? "") ?? 0;';
      case DataType.Boolean:
        return '$name = stdin.readlineSync().toString().toLowerCase() == "true";';
      case DataType.String:
        return '$name = stdin.readLineSync().toString();';

      case DataType.NaturalNumberArray:
      case DataType.RealArray:
      case DataType.IntegerArray:
        {
          String result = "$name";
          if (dataType == DataType.NaturalNumberArray ||
              dataType == DataType.IntegerArray) {
            result = '''
for (int i = 0; i< ${variableForNumberOfElement}; i++) {
${Values.tabs}${Values.tabs}${Values.tabs}print('Enter $name[\$i]: ');
${Values.tabs}${Values.tabs}${Values.tabs}$name.add(int.tryParse(stdin.readLineSync() ?? "") ?? 0);
${Values.tabs}${Values.tabs}}            
            ''';
          } else {
            result = '''
for (int i = 0; i< ${variableForNumberOfElement}; i++) {
${Values.tabs}${Values.tabs}${Values.tabs}print('Enter $name[\$i]: ');
${Values.tabs}${Values.tabs}${Values.tabs}$name.add(double.tryParse(stdin.readLineSync() ?? "") ?? 0);
${Values.tabs}${Values.tabs}}           
''';
          }
          return result;
        }
      case DataType.Real:
      default:
        return '$name = double.tryParse(stdin.readLineSync() ?? "") ?? 0;';
    }
  }
}
