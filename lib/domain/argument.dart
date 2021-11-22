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

  /// Convert a string from CLI to appropriate type in Dart
  String get inputConverterInDart {
    switch (dataType) {
      case DataType.NaturalNumber:
      case DataType.NaturalNumber0:
      case DataType.Integer:
      case DataType.Integer0:
        return '$name = int.tryParse(stdin.readLineSync() ?? "") ?? 0;';
      case DataType.Boolean:
        return '$name = stdin.readlineSync().toString().toLowerCase() == "true";';
      case DataType.String:
        return '$name = stdin.readLineSync().toString();';
      case DataType.Real:
      case DataType.Real0:
      default:
        return '$name = double.tryParse(stdin.readLineSync() ?? "") ?? 0;';
    }
  }
}
