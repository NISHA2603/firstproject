import 'package:firstproject/services/models/post_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/delete_intern_model.dart';

class DeleteInternApi {
  Future<DeleteInternModel> fetchApi({id}) async {
    ///Api
    var myUrl = "https://interns-new.herokuapp.com/list/$id";
    var myUri = Uri.parse(myUrl);

    var response = await http.delete(myUri);
    print("This is my DeleteInternModel response = ${response.body}");

    ///to check status of response
    if (response.statusCode == 200) {
      Map<String, dynamic> myJsonData = json.decode(response.body);

      var model = DeleteInternModel.fromJson(myJsonData);

      ///to get api response in model
      return model;
    } else {
      throw Exception('Failed to load SHIFTS_API');
    }
  }
}
