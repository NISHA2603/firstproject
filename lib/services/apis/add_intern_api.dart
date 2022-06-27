import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:firstproject/services/models/post_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// fetch api using dio >>
class SaveInternApi {
  Future<PostModel> fetchApi(
      {String? name,
      String? mobile,
      String? desi,
      String? email,
      File? imageFile}) async {
    var dio = Dio();
    var _url = "https://interns-new.herokuapp.com/list";

    ///image name is split
    List? list = imageFile?.path.split('/');
    var imageName = list!.last;

    FormData _formData = FormData.fromMap({
      "name": name,
      "mobile": mobile,
      "designation": desi,
      "email": email,
      if (imageFile != null)
        "profile_image": await MultipartFile.fromFile(imageFile.path,
            contentType: MediaType("image", "jpg"), filename: imageName)
    });
    // dio.options.headers['content-Type'] = 'application/json';
    //dio.options.headers["authorization"] = "Bearer ${token}";
    // dio.options.validateStatus(1);
    try {
      var response = await dio.post(_url, data: _formData);
      if (response.statusCode == 200) {
        var json = response.data;
        print("response > $json");
        return PostModel.fromJson(json);
      } else {
        print("else > response.statusCode ${response.statusCode}");
        //show error message
        throw Exception("Exception");
      }
    } catch (e) {
      // saveTransactionBloc.processOnError(e);
      print("inside catch () eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee > $e");
      throw Exception(e);
    }
  }
}

/// fetch api using http >>
// class SaveInternApi {
//   Future<PostModel> fetchApi({name, mobile, desi, email}) async {
//     ///Api
//     var myUrl = "https://interns-new.herokuapp.com/list";
//     var myUri = Uri.parse(myUrl);
//     var _body = {
//       "name": name,
//       "mobile": mobile,
//       "designation": desi,
//       "email": email
//     };
//     var response = await http.post(myUri, body: _body);
//     print("This is my SaveInternApi response = ${response.body}");
//
//     ///to check status of response
//     if (response.statusCode == 200) {
//     Map<String, dynamic> myJsonData = json.decode(response.body);
//
//       var model = PostModel.fromJson(myJsonData);
//
//       ///to get api response in model
//     return model;
//     } else {
//       throw Exception('Failed to load SHIFTS_API');
//     }
//   }
// }
