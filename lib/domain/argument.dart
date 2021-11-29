import 'package:formal_specification/domain/data_type.dart';
import 'package:formal_specification/domain/languages/lanaguage.dart';
import 'package:formal_specification/domain/string_extension.dart';

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
    return '${dataType.toDart()} $name;';
  }

  bool get isArrayType {
    return dataType == DataType.NaturalNumberArray ||
        dataType == DataType.RealArray ||
        dataType == DataType.IntegerArray;
  }

  /// Convert a string from CLI to appropriate type in Dart
  String get inputConverterInDart {
    switch (dataType) {
      case DataType.NaturalNumber:

      case DataType.Integer:
        return '$name = int.tryParse(stdin.readLineSync() ?? "") ?? 0;';
      case DataType.Boolean:
        return '$name = stdin.readlineSync().toString().toLowerCase() == "true";';
      case DataType.String:
        return '$name = stdin.readLineSync().toString();';

      /// TODO Array input
      case DataType.NaturalNumberArray:
      case DataType.RealArray:
      case DataType.IntegerArray:
        {
          String result = "";
        }
        return '';

      case DataType.Real:
        return '';
      default:
        return '$name = double.tryParse(stdin.readLineSync() ?? "") ?? 0;';
    }
  }
}
