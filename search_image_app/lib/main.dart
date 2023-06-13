// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  runApp(
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //         create: (_) =>
    //             DishesProvider(categoryRepository: CategoryRepository())),
    //   ],
    //   child:
    MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterBasicApp(),
    );
  }
}
