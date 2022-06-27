import 'dart:io';

import 'package:firstproject/services/models/list_model.dart';
import 'package:firstproject/services/models/post_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/update_intern_model.dart';

class UpDateInternApi {
  Future<UpdateInternModel> fetchApi({id, name, mobile, desi, email}) async {
    ///Api

    var myUrl = "https://interns-new.herokuapp.com/list/$id";
    var myUri = Uri.parse(myUrl);
    var _body = {
      "name": name,
      "mobile": mobile,
      "designation": desi,
      "email": email
    };
    // try {
      var response = await http.put(myUri, body: _body);
      print("This is my UpdateInternApi response = ${response.body}");

      ///to check status of response
      if (response.statusCode == 200) {
        Map<String, dynamic> myJsonData = json.decode(response.body);
        var model = UpdateInternModel.fromJson(myJsonData);

        ///to get api response in model
        return model;
      } else {
        throw Exception('Failed to load SHIFTS_API');
      }
    // } catch (e) {
    //   print(e);
    //   throw Exception(e);
    // }
  }
}
