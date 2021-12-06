/// Check xem có N1, N2... hay không hay chỉ có N*, N ...
/// Integer0 <=> N* , Real0 <=> R*
enum DataType {
  Integer,
  IntegerArray,
  Real,
  RealArray,
  NaturalNumber,
  NaturalNumberArray,
  Boolean,
  String,
}

extension DataTypeExtension on DataType {
  String convertToString() {
    switch (this) {
      case DataType.NaturalNumber:
        return 'N';
      case DataType.NaturalNumberArray:
        return 'N*';
      case DataType.Integer:
        return 'Z';
      case DataType.IntegerArray:
        return 'Z*';
      case DataType.Real:
        return 'R';
      case DataType.RealArray:
        return 'R*';
      case DataType.Boolean:
        return 'B';
      case DataType.String:
        return 'char*';
      default:
        return 'R';
    }
  }

  String toDart() {
    switch (this) {
      case DataType.NaturalNumber:
        return 'int';
      case DataType.NaturalNumberArray:
        return 'List<int>';
      case DataType.Integer:
        return 'int';
      case DataType.IntegerArray:
        return 'List<int>';
      case DataType.Real:
        return 'double';
      case DataType.RealArray:
        return 'List<double>';
      case DataType.Boolean:
        return 'bool';
      case DataType.String:
        return 'String';
      default:
        return 'double';
    }
  }
}
