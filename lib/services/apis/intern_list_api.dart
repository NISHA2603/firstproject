

import 'package:firstproject/services/models/list_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InternListApi {
  Future<ListModel> fetchApi() async {
    var myUrl = "https://interns-new.herokuapp.com/list";
    var myUri = Uri.parse(myUrl);
    var response = await http.get(myUri);
     print("This is my response = ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> myJsonData = json.decode(response.body);
      var model = ListModel.fromJson(myJsonData);

      return model;
    } else {
      throw Exception('Failed to load SHIFTS_API');
    }
  }
}

// try {
// final response = await http.get( );
//
// if (response.statusCode == 200) {
// return ShiftsModel.fromJson(json.decode(response.body));
// } else if (response.statusCode == 401) {
// return ShiftsModel.fromJson(json.decode(response.body));
// } else {
// throw Exception('Failed to load SHIFTS_API');
// }
// } catch (e) {
// shiftsBloc.processOnError(e);
// throw Exception("something went wrong!! SHIFTS_API");
// }
