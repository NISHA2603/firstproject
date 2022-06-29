import 'package:firstproject/services/models/localString.dart';
import 'package:firstproject/ui/screens/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        translations: LocalString(),
        locale:  const Locale('en', 'US'),

        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.deepPurple,
          ),
        ),
        darkTheme: ThemeData.dark(),
        home: ListScreen(),
      ),
    );
  }
}
