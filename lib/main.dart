import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:query_builder_task/ui/home_screen.dart';
import 'package:query_builder_task/view_models/user_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserViewModel>(
        create: (_) => UserViewModel(),
        child: Consumer<UserViewModel>(builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Query Builder',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const HomeScreen(),
          );
        }));
  }
}
