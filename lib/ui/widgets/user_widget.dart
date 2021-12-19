import 'package:flutter/material.dart';
import 'package:query_builder_task/models/user_model.dart';

class UserWidget extends StatelessWidget {
  final UserModel? userModel;

  const UserWidget({this.userModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFE5E5E5),
              child: Icon(userModel!.gender == "Male"
                  ? Icons.male
                  : Icons.female),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel?.fullName ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  userModel?.gender ?? '',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
