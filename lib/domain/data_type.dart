/// Check xem có N1, N2... hay không hay chỉ có N*, N ...
/// Integer0 <=> N* , Real0 <=> R*
enum DataType {
  Integer,
  Integer0,
  Real,
  Real0,
  NaturalNumber,
  NaturalNumber0,
  Boolean,
  String,
}

extension DataTypeExtension on DataType {
  String convertToString() {
    switch (this) {
      case DataType.NaturalNumber:
        return 'N';
      case DataType.NaturalNumber0:
        return 'N*';
      case DataType.Integer:
        return 'Z';
      case DataType.Integer0:
        return 'Z*';
      case DataType.Real:
        return 'R';
      case DataType.Real0:
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
      case DataType.NaturalNumber0:
        return 'int';
      case DataType.Integer:
        return 'int';
      case DataType.Integer0:
        return 'int';
      case DataType.Real:
        return 'double';
      case DataType.Real0:
        return 'double';
      case DataType.Boolean:
        return 'bool';
      case DataType.String:
        return 'String';
      default:
        return 'double';
    }
  }
}
