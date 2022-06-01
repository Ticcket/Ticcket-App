import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticcket/core/res/app.dart';
import 'package:http/http.dart' as http;
import 'package:ticcket/models/user.dart';

class UserController {
    
    static var client = http.Client();
    static Map<String,String> _headers = {
        "Accept": "application/json",
        
    };

  static Future<bool> updatePhoto(File photo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var t = await pref.getString("object")!;
    Map user = jsonDecode(t);

    try {
      _headers.addAll({"Authorization": "Bearer ${user['token']}"});

      var request = new http.MultipartRequest("POST", Uri.http(AppConstants.server, 'api/user/u/photo'));
      request.headers.addAll(_headers);
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          photo.path,
        )
      );

      var response = await request.send();

      if(response.statusCode == 200){
        var resp = await response.stream.bytesToString();
        user['photo'] = jsonDecode(resp)['data']['photo'];
        User u = User.fromJson(user);
        pref.setString("object", u.toJson());

        return true;
      }
      
    }catch(e) {
      print(e);
      return false;
    }

    return false;
  }

  static Future<bool> editUserData({required String name, required String email, required String oldPassword, required String newPassword}) async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    var t = await pref.getString("object")!;
    Map u = jsonDecode(t);


    Map body = {};
    try {
      _headers.addAll({"Authorization": "Bearer ${u['token']}"});

      if(name.isNotEmpty && name != u['name'])
        body.addAll({"name": name});
      if(email.isNotEmpty && email != u['email'])
        body.addAll({"email": email});
      if(newPassword.isNotEmpty)
        if(oldPassword.isNotEmpty)
          body.addAll({"new_password": newPassword, "old_password": oldPassword});

      var response = await client.put(
        headers: _headers,
        body: body,
        Uri.http(AppConstants.server, "api/user"),
      );

      if(response.statusCode == 200) {
        var resp = jsonDecode(response.body);
        resp['data']['token'] = u['token'];
        var user = User.fromJson(resp['data']);
        pref.setString("object", user.toJson());
        
        return true;
      }


    }catch(e){
      print(e);
      return false;
    }

    return false;
  }
  
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