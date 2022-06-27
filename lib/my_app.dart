
import 'package:firstproject/ui/screens/list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple,
        ),

      ),
      darkTheme: ThemeData.dark(),
      home: ListScreen(),

    );
  }
}
