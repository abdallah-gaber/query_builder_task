import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:query_builder_task/ui/widgets/user_widget.dart';

import '../main.dart';

class FilterResultScreen extends ConsumerWidget {
  const FilterResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userProvider);

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
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 11,
                    ),
                    const Text(
                      "Users",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 32),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: data.filteredUsersList.isNotEmpty
                          ? ListView.builder(
                              itemCount: data.filteredUsersList.length,
                              itemBuilder: (context, index) {
                                return UserWidget(
                                    userModel: data.filteredUsersList[index]);
                              })
                          : const Center(
                              child: Text(
                                  'No Data with these filter Query Params'),
                            ),
                    )
                  ])),
        ));
  }
}
