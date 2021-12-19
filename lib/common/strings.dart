class ColumnNames {
  static const String ID_COLUMN = "User ID";
  static const String FIRST_NAME_COLUMN = "First Name";
  static const String LAST_NAME_COLUMN = "Last Name";
  static const String FULL_NAME_COLUMN = "Full Name";
  static const String GENDER_COLUMN = "Gender";
  static const String AGE_COLUMN = "Age";

  static bool useNumberOperator(String operator) {
    return operator == ID_COLUMN || operator == AGE_COLUMN;
  }
}

class NumberOperators {
  static const String EQUALS = "=";
  static const String NOT_EQUALS = "!=";
  static const String GREATER_THAN = ">";
  static const String LESS_THAN = "<";
}

class StringOperators {
  static const String STARTS_WITH = "Starts with";
  static const String ENDS_WITH = "Ends with";
  static const String CONTAINS = "Contains";
  static const String EXACT = "Exact";
}

class LogicOperators {
  static const String AND = "AND";
  static const String OR = "OR";

  static bool combineLogicOperations(bool op1, bool op2, String operator) {
    return operator == AND ? op1 && op2 : op1 || op2;
  }
}
