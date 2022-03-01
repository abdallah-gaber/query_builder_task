import 'package:flutter/material.dart';
import 'package:query_builder_task/models/user_model.dart';

class UserWidget extends StatelessWidget {
  final UserModel? userModel;

  const UserWidget({this.userModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 13),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14))
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFE5E5E5),
              child: Icon(userModel!.gender == "Male"
                  ? Icons.male
                  : Icons.female),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel?.fullName ?? '',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  userModel?.gender ?? '',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
