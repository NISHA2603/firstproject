import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/apis/intern_list_api.dart';
import '../../services/apis/add_intern_api.dart';

class AddIntern extends StatelessWidget {
  const AddIntern({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.pink,
        title: Text('Add Intern Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: InternForm(),
    );
  }
}

class InternForm extends StatefulWidget {
  const InternForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InternFormState();
  }
}

class _InternFormState extends State<InternForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? selectedimage;

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey();
    return Form(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //name form
            TextFormField(
              controller: nameController,
              onTap: () {
                print('name');
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter Your Name',
                labelText: 'Name',
              ),
            ),

            ///  mobile form
            TextFormField(
              controller: mobileController,
              onTap: () {
                print('mobil');
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.phone_android),
                hintText: 'Enter Valid Mobile Number',
                labelText: 'Mobile Number',
              ),
            ),

            ///designation form
            TextFormField(
              controller: designationController,
              onTap: () {
                print('designation');
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                icon: Icon(Icons.perm_identity_outlined),
                hintText: 'Enter Your Designation',
                labelText: 'Designation',
              ),
            ),

            ///email form
            TextFormField(
              controller: emailController,
              onTap: () {
                print('email');
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                icon: Icon(Icons.mail_outline),
                hintText: 'Enter Valid Email ID',
                labelText: 'Email',
              ),
            ),

            ///designation form

            Container(
              width: 15.0,
              height: 15.0,
            ),

            /// profile_image for

            Container(
              height: 100.0,
              width: 100.0,
              //  color: Colors.red,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  selectedimage == null
                      ? Container(
                          decoration: BoxDecoration(
                            //image: DecorationImage(image: FileImage(selectedimage!)),
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          //color: Colors.lightBlueAccent,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(selectedimage!),
                                fit: BoxFit.fill),
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          //color: Colors.lightBlueAccent,
                        ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        var image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        var img = File(image!.path);
                        setState(() {
                          selectedimage = img;
                        });
                      },
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.white),

                        //color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () async {
                  /// show loading here
                  Get.dialog(Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ],
                    ),
                  )).then((value) {
                    Get.back();
                    if (value.Code == 1) {
                      var api = InternListApi();
                      api.fetchApi();
                      setState(() {});
                    }
                  });

                  ///to get user input
                  print(nameController.text);
                  print(mobileController.text);
                  print(designationController.text);
                  print(emailController.text);
                  print(selectedimage);

                  ///object of api
                  var api = SaveInternApi();

                  /// Api call
                  await api
                      .fetchApi(
                          desi: designationController.text,
                          email: emailController.text,
                          mobile: mobileController.text,
                          name: nameController.text,
                          imageFile: selectedimage)
                      .then(
                    (value) {
                      if (value.code == 1) {
                        Get.back();
                      }
                    },
                  );
                },
                child: const Text('Submit'),
              ),
            ),
            // Container(
            //   child: CircularProgressIndicator(),
            // )
          ],
        ),
      ),
    );
  }
}
