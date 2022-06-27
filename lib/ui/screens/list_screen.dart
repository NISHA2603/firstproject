import 'dart:io';

import 'package:firstproject/ui/screens/iitem_details_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/apis/delete_intern_api.dart';
import '../../services/apis/intern_list_api.dart';
import '../../services/models/list_model.dart';
import 'add_intern_screen.dart';
import 'add_themes.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  var api = InternListApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interns List"),
        // backgroundColor: Colors.blueGrey,
        // shadowColor: Colors.brown,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.add),
              title: Text(" Add New Interns"),
              onTap: () {
                Get.to(AddIntern());
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Themes "),
              onTap: () {
                Get.to(AddThemes());
              },
            )
            // DrawerHeader(child: IconButton(onPressed: () {  }, icon: Icon(Icons.list_alt),))
          ],
        ),
      ),
      // backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: api.fetchApi(),
            builder: (context, AsyncSnapshot<ListModel> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: snapshot.data!.result!.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(ItemDetailsScreen(
                                  designation:
                                      snapshot.data!.result![i].designation,
                                  email: snapshot.data!.result![i].email,
                                  mobile: snapshot.data!.result![i].mobile,
                                  name: snapshot.data!.result![i].name,
                                  id: snapshot.data!.result![i].id.toString(),
                                  isEdit: true,
                                ))?.then((value) {
                                  Get.back();
                                  print(
                                      "returning from ItemDetailsScreen $value");
                                  // if(value.Code==1) {
                                  var api = InternListApi();
                                  api.fetchApi();
                                  setState(() {});
                                  // }
                                });
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                setState(() {});
                                var api = DeleteInternApi();
                                await api
                                    .fetchApi(
                                  id: snapshot.data!.result![i].id.toString(),
                                )
                                    .then((value) {
                                  print(value);
                                  Get.back();

                                  /// to update ui
                                  {
                                    var api = InternListApi();
                                    api.fetchApi();
                                    setState(() {});
                                  }
                                });
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                        onTap: () {
                          // print(snapshot.data!.result![i].email);
                          Get.to(ItemDetailsScreen(
                            name: snapshot.data!.result![i].name!,
                            mobile: snapshot.data!.result![i].mobile.toString(),
                            email: snapshot.data!.result![i].email!,
                            designation: snapshot.data!.result![i].designation,
                            profile_image:
                                File(snapshot.data!.result![i].profile_image!),
                          ));
                        },
                        title: Text(snapshot.data!.result![i].name!),
                        subtitle: Text(snapshot.data!.result![i].email!),
                      );
                    });
              } else if (snapshot.hasError) {
                return Container(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Container(
                  child: CircularProgressIndicator(),
                  color: Colors.black,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
