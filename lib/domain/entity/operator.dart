enum Operator {
  Add,
  Substract,
  Multiply,
  Divide,
  Modular,
  Larger,
  Smaller,
  Equal,
  Differ,
  LargerOrEqual,
  SmallerOrEqual,
  Not,
  And,
  Or,
}

class OperatorHelper {
  OperatorHelper._();

  static const Map<String, Operator> _operatorsMapper = {
    '+': Operator.Add,
    '-': Operator.Substract,
    '*': Operator.Multiply,
    '/': Operator.Divide,
    '%': Operator.Modular,
    '>': Operator.Larger,
    '<': Operator.Smaller,
    '==': Operator.Equal,
    '!=': Operator.Differ,
    '>=': Operator.LargerOrEqual,
    '<=': Operator.SmallerOrEqual,
    '!': Operator.Not,
    '&&': Operator.And,
    '||': Operator.Or,
  };

  static Operator? fromString(String value) {
    return _operatorsMapper.containsKey(value) ? null : _operatorsMapper[value];
  }
}
