import 'package:formal_specification/domain/data_type.dart';
import 'package:formal_specification/domain/string_extension.dart';

class Argument {
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
}
