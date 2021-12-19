import 'package:flutter/material.dart';
import 'package:query_builder_task/data/api_caller.dart';
import 'package:query_builder_task/models/query_model.dart';
import 'package:query_builder_task/models/user_model.dart';

class UserViewModel with ChangeNotifier{
  List<UserModel>? allFakeUsersList;
  List<UserModel>? filteredUsersList;

  loadAllUsersList(){
    ApiCaller().getAllFakeUsersList().then((allUsers) {
      allFakeUsersList = allUsers;
    });
  }

  filterUsersList(List<QueryModel> queryModels, String logicOperator){

  }

}