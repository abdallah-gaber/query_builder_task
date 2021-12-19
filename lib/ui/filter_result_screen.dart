import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:query_builder_task/ui/widgets/user_widget.dart';
import 'package:query_builder_task/view_models/user_view_model.dart';

class FilterResultScreen extends StatefulWidget {
  const FilterResultScreen({Key? key}) : super(key: key);

  @override
  _FilterResultScreenState createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF1F1F1),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        backgroundColor: const Color(0xFFF1F1F1),
        body: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Users",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 26),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<UserViewModel>(
                    builder: (context, userViewModel, child) {
                  return Expanded(
                    child: userViewModel.filteredUsersList.isNotEmpty ? ListView.builder(
                        itemCount: userViewModel.filteredUsersList.length,
                        itemBuilder: (context, index) {
                          return UserWidget(
                              userModel: userViewModel.filteredUsersList[index]);
                        }) : const Center(
                          child: Text('No Data with these filter Query Params'),
                        ),
                  );
                })
              ])),
        ));
  }
}
