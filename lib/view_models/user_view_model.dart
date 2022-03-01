import 'package:flutter/material.dart';
import 'package:query_builder_task/common/strings.dart';
import 'package:query_builder_task/models/query_model.dart';
import 'package:query_builder_task/models/user_model.dart';

class UserViewModel with ChangeNotifier {
  List<UserModel> allFakeUsersList = [];
  List<UserModel> filteredUsersList = [];

  UserViewModel(this.allFakeUsersList);

  filterUsersList(List<QueryModel> queryModels, List<String> logicOperators) {
    filteredUsersList = [];
    bool matched;
    List<bool> combinedList;
    for (UserModel um in allFakeUsersList) {
      matched = false;
      if ((logicOperators.isEmpty &&
          queryModels.length == 1 &&
          meetQuery(queryModels[0], um))) {
        matched = true;
      } else {
        combinedList = [];
        for (int i = 0 ; i<logicOperators.length ; i++) {
          if(combinedList.isEmpty){
            combinedList.add(meetQuery(queryModels[0], um));
          }
          if(logicOperators[i] == LogicOperators.AND){
            combinedList.last = combinedList.last && meetQuery(queryModels[i + 1], um);
          }else{
            combinedList.add(meetQuery(queryModels[i + 1], um));
          }
        }

        for(bool itemInCombined in combinedList){
          if(itemInCombined){
            matched = true;
            break;
          }
        }
      }

      if (matched) {
        filteredUsersList.add(um);
      }
    }
    notifyListeners();
  }

  bool meetQuery(QueryModel qm, UserModel um) {
    if (!ColumnNames.useNumberOperator(qm.columnName!)) {
      switch (qm.columnName) {
        case ColumnNames.FIRST_NAME_COLUMN:
          return meetSubQuery(qm.data!, qm.operator!, um.firstName!, false);
        case ColumnNames.LAST_NAME_COLUMN:
          return meetSubQuery(qm.data!, qm.operator!, um.lastName!, false);
        case ColumnNames.FULL_NAME_COLUMN:
          return meetSubQuery(qm.data!, qm.operator!, um.fullName!, false);
        case ColumnNames.GENDER_COLUMN:
          return meetSubQuery(qm.data!, qm.operator!, um.gender!, false);
      }
    } else {
      switch (qm.columnName) {
        case ColumnNames.ID_COLUMN:
          return meetSubQuery(
              qm.data!, qm.operator!, um.userId.toString(), true);
        case ColumnNames.AGE_COLUMN:
          return meetSubQuery(qm.data!, qm.operator!, um.age.toString(), true);
      }
    }
    return false;
  }

  bool meetSubQuery(String columnValue, String operator, String userColumnValue,
      bool isNumber) {
    if (isNumber) {
      switch (operator) {
        case NumberOperators.EQUALS:
          return int.tryParse(columnValue) == int.tryParse(userColumnValue);
        case NumberOperators.NOT_EQUALS:
          return int.tryParse(columnValue) != int.tryParse(userColumnValue);
        case NumberOperators.GREATER_THAN:
          return (int.tryParse(userColumnValue) ?? 0) >
              (int.tryParse(columnValue) ?? 0);
        case NumberOperators.LESS_THAN:
          return (int.tryParse(userColumnValue) ?? 0) <
              (int.tryParse(columnValue) ?? 0);
      }
    } else {
      switch (operator) {
        case StringOperators.STARTS_WITH:
          return userColumnValue
              .toLowerCase()
              .startsWith(columnValue.toLowerCase());
        case StringOperators.ENDS_WITH:
          return userColumnValue
              .toLowerCase()
              .endsWith(columnValue.toLowerCase());
        case StringOperators.CONTAINS:
          return userColumnValue
              .toLowerCase()
              .contains(columnValue.toLowerCase());
        case StringOperators.EXACT:
          return columnValue.toLowerCase() == userColumnValue.toLowerCase();
      }
    }

    return false;
  }
}
