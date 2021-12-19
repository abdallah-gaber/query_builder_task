import 'package:dio/dio.dart';
import 'package:query_builder_task/models/user_model.dart';

class ApiCaller {
  Dio dio = Dio();

  Future<List<UserModel>> getAllFakeUsersList() async {
    try {
      var response = await dio.get(
        'https://mocki.io/v1/fb545e3a-6df0-4c95-b7ee-0704ffb5ba55',
      );

      // Decoding Response.
      var decoded = response.data;

      if (response.statusCode! >= 200 && decoded != null) {
        List<UserModel> usersList = [];
        for (var item in decoded) {
          usersList.add(UserModel.fromJson(item));
        }
        return usersList;
      } else {
        return [];
      }
    } on DioError catch (_) {
      return [];
    }
  }
}
