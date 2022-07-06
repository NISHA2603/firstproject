import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firstproject/ui/screens/connectivity_check.dart';
import 'package:firstproject/ui/screens/iitem_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../services/apis/delete_intern_api.dart';
import '../../services/apis/intern_list_api.dart';
import '../../services/models/list_model.dart';
import '../../services/streams/connectivity_streams.dart';
import 'add_intern_screen.dart';
import 'add_themes.dart';
import 'internet.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  var api = InternListApi();

  final List locale = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'हिन्दी', 'locale': Locale('hi', 'IN')},
    {'name': 'ગુજરાતી', 'locale': Locale('gu', 'IN')},
    {'name': 'મરાઠી', 'locale': Locale('mr', 'IN')}
  ];

  var obj = ConnectivityStreams();

  void checkInternet() async {
    var isInternet = await ConnectivityCheck().isInternet();
    print(isInternet);

    if (!isInternet) {
      Get.defaultDialog(
          title: "No Internet",
          content: Text(
            "Please check your internet connectivity",
          ),
          actions: [
            MaterialButton(
              onPressed: () => checkInternet(),
              child: Text("REFRESH"),
            )
          ]);
    } else {
      Get.back();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // Timer.periodic(Duration(milliseconds: 2000), (timer) {
    contStream.processConn();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contStream.processConn();
    return Scaffold(
      appBar: AppBar(
        title: Text('internslist'.tr),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: () {
                  builddialog(context);
                },
                icon: Icon(Icons.language),
              )),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.add),
              title: Text('addnewinterns'.tr),
              onTap: () {
                Get.to(AddIntern());
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('themes'.tr),
              onTap: () {
                Get.to(AddThemes());
              },
            )
          ],
        ),
      ),
      // backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: contStream.conn,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            print(snapshot.data.toString() + "  kkkkk ");
            if (snapshot.hasData) {
              print(
                  snapshot.data.toString() + "  kkkkkkkkkkkkkkkkkkkkkkkkk ");
              if (snapshot.data!) {
                return FutureBuilder(
                  future: api.fetchApi(),
                  builder: (context, AsyncSnapshot<ListModel> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          // reverse: true,
                          itemCount: snapshot.data!.result!.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.to(ItemDetailsScreen(
                                        designation: snapshot
                                            .data!.result![i].designation,
                                        email:
                                            snapshot.data!.result![i].email,
                                        mobile: snapshot
                                            .data!.result![i].mobile,
                                        name:
                                            snapshot.data!.result![i].name,
                                        id: snapshot.data!.result![i].id
                                            .toString(),
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
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      setState(() {});
                                      var api = DeleteInternApi();
                                      await api
                                          .fetchApi(
                                        id: snapshot.data!.result![i].id
                                            .toString(),
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
                                  mobile: snapshot.data!.result![i].mobile
                                      .toString(),
                                  email: snapshot.data!.result![i].email!,
                                  designation:
                                      snapshot.data!.result![i].designation,
                                  profile_image: File(snapshot
                                      .data!.result![i].profile_image!),
                                ));
                              },
                              title: Text(snapshot.data!.result![i].name!),
                              subtitle:
                                  Text(snapshot.data!.result![i].email!),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Container(
                          child: Text(snapshot.error.toString()),
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                          // color: Colors.black,
                        ),
                      );
                    }
                  },
                );
              } else {
                return Center(
                  child: Container(
                    child: Text("no Internet"),
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Container(
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else {
              return Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }

  builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text('choosealanguage'.tr),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            print(locale[index]['name']);
                            updatelanguage(locale[index]['locale']);
                          },
                          child: Text(
                            locale[index]['name'],
                          )),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.purple,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  updatelanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }
}
