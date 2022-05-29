import 'dart:convert';
import 'package:ticcket/core/res/app.dart';
import 'package:http/http.dart' as http;
import 'package:ticcket/models/user.dart';

class UserController {
    
    static var client = http.Client();
    static Map<String,String> _headers = {
        "Accept": "application/json",
        
    };
  
  static Future<dynamic> getUserData(String token) async {
    var data;
    _headers.addAll({"Authorization": "Bearer " + token});
    try {

      var response = await client.get(
        headers: _headers,
        Uri.http(AppConstants.server, "api/user"),
      );
      
      if(response.statusCode == 200){
        data = jsonDecode(response.body);
        return User.fromJson(data);
      }else {

        data = null;
      }

    }catch (e) {
      print(e);
      data = null;
    }


    return data;
  }
}