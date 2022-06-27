import 'dart:io';

import 'package:firstproject/ui/widgets/loading_widget.dart';
import 'package:firstproject/ui/widgets/my_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../services/apis/update_intern_api.dart';

class ItemDetailsScreen extends StatefulWidget {


  ItemDetailsScreen({
    Key? key,
    this.name,
    this.mobile,
    this.email,
    this.isEdit = false,
    this.id,
    this.designation,
    this.profile_image
  }) : super(key: key);
  final String? name;
  final String? mobile;
  final String? email;
  final bool? isEdit;
  final String? id;
  final String? designation;
  final File? profile_image;

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}
class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  var nameControll = TextEditingController();
  var mobileControll = TextEditingController();
  var emailControll = TextEditingController();
  var designationControll = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    showDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intern Details'),
      ),
      body: Container(
        // color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.isEdit! ? editView() : detailsView(),
              if (widget.isEdit!)
                ElevatedButton(
                  onPressed: () async {
                    /// to check if keyboard has focus or not
                    if (Get.focusScope!.hasFocus) {
                      Get.focusScope!.unfocus();
                    }
                    ///show loading dialog
                    Get.dialog(WillPopScope(
                      onWillPop: () async {
                        return await false;
                      },
                      child: MyDialogWidget(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyLoadingWidget(),
                          ],
                        ),
                      ),
                    )).then((value) {
                      /// to taking back to intern list screen after loading dialog is disposed
                      Get.back();
                    });
                    var api = UpDateInternApi();
                    await api.fetchApi(
                            email: emailControll.text,
                            mobile: mobileControll.text,
                            name: nameControll.text,
                            desi: designationControll.text,
                            id: widget.id)
                        .then((value) {
                      if (value.code == 1) {
                        // Navigator.of(context).pop();
                        /// here disposing loading dialog
                        Get.back();
                      }
                    });
                  },
                  child: Text("Save"),
                ),],
          ),
        ),
      ),
    );
  }
  Widget detailsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(widget.name!),
        Text(widget.mobile!),
        Text(widget.email!),
        Text(widget.designation!),
        if(widget.profile_image!=null)
        Image.network("https://interns-new.herokuapp.com"+widget.profile_image!.path)
      ],
    );
  }
  Widget editView() {
    return Container(
      child: Column(
        children: [
          TextField(decoration: InputDecoration(hintText: "name"),
            controller: nameControll,
          ),
          TextField(decoration: InputDecoration(hintText: "mobile"),
            controller: mobileControll,
          ),
          TextField(decoration: InputDecoration(hintText: "email"),
            controller: emailControll,
          ),
          TextField(decoration: InputDecoration(hintText: "designation"),
            controller: designationControll,
          ),
        ],
      ),
    );
  }
  void showDetails() {
    setState(() {
      nameControll.text = widget.name!;
      mobileControll.text = widget.mobile!;
      emailControll.text = widget.email!;
      designationControll.text = widget.designation!;
    });
  }
}
