import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../service/themes_Stream.dart';

class AddThemes extends StatelessWidget {
  const AddThemes({Key? key}) : super(key: key);

  // var obj = ThemeStreams();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Themes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                onTap:()=> changeTheme(theme: "Day"),
                title: Text("Day"),
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                onTap:()=> changeTheme(theme: "Night"),
                title: Text("Night"),
              ),
            ),
            SizedBox(height: 15),
            Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  onTap: ()=>changeTheme(theme: "Pink"),
                  title: Text("Pink"),
                )),
          ],
        ),
      ),
    );
  }

  changeTheme({required String theme}) {
    switch (theme) {
      case "Pink":
        Get.changeThemeMode(ThemeMode.system);
        break;
      case "Day":
        Get.changeThemeMode(ThemeMode.light);
        break;
      case "Night":
        Get.changeThemeMode(ThemeMode.dark);
        break;
      default:
    }
    // if (Get.isDarkMode) {
    //   Get.changeThemeMode(ThemeMode.dark);
    // } else {
    //   Get.changeThemeMode(ThemeMode.dark);
    // }
  }

  // ThemeMode myTheme(){
  //   return
  // }
}


