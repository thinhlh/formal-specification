import 'package:formal_specification/domain/data_type.dart';

extension FSString on String {
  static const String regexExact = r"(?<=\b|)=\b";

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
    String result = this;
    for (int i = 0; i < this.length - 1; i++) {
      if (this[i] == '=') {
        if ([
          '<', // <=
          '>', // >=
          '!', // !=
        ].contains(this[i - 1])) {
          // Do nothing
        } else {
          if (this[i + 1] == '=') {
            continue;
          } else {
            final list = this.list..insert(i, '=');
            result = list.join();
            break;
          }
        }
      }
    }

    return result;

    // RegExp(regexExact).allMatches(this).forEach((element) {
    //   print(element.group(0));
    // });
    // return this.replaceAll(RegExp(regexExact, multiLine: true), '==');
  }

  DataType toDataType() {
    switch (this) {
      case 'N':
        return DataType.NaturalNumber;
      case 'N*':
        return DataType.NaturalNumberArray;
      case 'Z':
        return DataType.Integer;
      case 'Z*':
        return DataType.IntegerArray;
      case 'R':
        return DataType.Real;
      case 'R*':
        return DataType.RealArray;
      case 'B':
        return DataType.Boolean;
      case 'char*':
        return DataType.String;
      default:
        return DataType.Real;
    }
  }
}
