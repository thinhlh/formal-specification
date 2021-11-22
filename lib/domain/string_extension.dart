import 'package:formal_specification/domain/data_type.dart';

extension FSString on String {
  static const String regexExact = r"\b=\b";

  String get reversed {
    String result = '';
    for (String char in this.list.reversed) {
      result += char;
    }
    return result;
  }

  Iterable<String> iterable() sync* {
    for (var i = 0; i < length; i++) {
      yield this[i];
    }
  }

  List<String> get list {
    return this.iterable().toList();
  }

  String removeWhiteSpace() {
    return this.trim().replaceAll(' ', '');
  }

  /// Replace any equals operator from precondition to equal programming language operators
  String replaceEquals() {
    return this.replaceAll(RegExp(regexExact, multiLine: true), '==');
  }

  DataType toDataType() {
    switch (this) {
      case 'N':
        return DataType.NaturalNumber;
      case 'N*':
        return DataType.NaturalNumber0;
      case 'Z':
        return DataType.Integer;
      case 'Z*':
        return DataType.Integer0;
      case 'R':
        return DataType.Real;
      case 'R*':
        return DataType.Real0;
      case 'B':
        return DataType.Boolean;
      case 'char*':
        return DataType.String;
      default:
        return DataType.Real;
    }
  }
}
