import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticcket/core/res/app.dart';
import 'package:http/http.dart' as http;

class Auth {
  static var client = http.Client();
  static Map<String,String> _headers = {
      "Accept": "application/json",
  };

  static Future<dynamic> login({required String email, required String password}) async {
      var data;
      try {
        var response = await client.post(
          headers: _headers,
          Uri.http(AppConstants.server, "api\/login"),
          body: {
            'email': email,
            'password': password,
            'api_key': AppConstants.apiKey
          }
        );

        if(response.statusCode == 200)
          data = [true, jsonDecode(response.body)];
        else if (response.statusCode == 422)
          data = [false, jsonDecode(response.body)];
        else
          data = null;

      } catch (e) {
        print(e);
        data = null;
      }

      return data;
  }

  static Future<dynamic> register({required String name, required String email, required String password, required String repassword}) async {
    
    var data;
    
    try {
      var response = await client.post(
          headers: _headers,
          Uri.http(AppConstants.server, "api\/register"),
          body: {
            'name': name,
            'email': email,
            'password': password,
            're_password': repassword,
            'api_key': AppConstants.apiKey
          }
        );

        if (response.statusCode == 200)
          data = [true];
        else if (response.statusCode == 422)
          data = [false, jsonDecode(response.body)];
        else
          data = null;
      
    }catch (e) {
      print(e);
      data = null;
    }

    return data;
  }

  static Future<bool> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var t = await pref.getString("object")!;
    String token = jsonDecode(t)['token'];

    try {
      
      _headers.addAll({"Authorization": "Bearer $token"});

      var response = await client.get(
        headers: _headers,
        Uri.http(AppConstants.server, "api/user/logout"),
      );

      if(response.statusCode == 200){
        pref.clear();
        return true;
      }else{
        return false;
      }


    }catch (e) {
      print(e);
      return false;
    }

  }

}