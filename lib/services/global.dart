import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticcket/core/res/app.dart';
import 'package:ticcket/models/user.dart';
import 'package:http/http.dart' as http;

class Global {

  static User? user;
  static var client = http.Client();
  static Map<String,String> _headers = {
      "Accept": "application/json",
  };

  Global () {
    // user = getUser("object");
  }

  static Future<bool> isBooked(event_id) async {
    User user = await getUser();

    try {
      _headers.addAll({"Authorization": "Bearer ${user.token}"});

      var response = await client.get(
        headers: _headers,
        Uri.http(AppConstants.server, "api/events/$event_id/organizers")
      );

      if (response.statusCode == 404){
        return true;
      }

      return false;
    }catch (e) {
      print(e);
      return false;
    }

  }

  static Future<List> getOrganizers(event_id) async {
    User user = await getUser();
    
    List organizers = [];
    try {
      _headers.addAll({"Authorization": "Bearer ${user.token}"});

      var response = await client.get(
        headers: _headers,
        Uri.http(AppConstants.server, "api/events/$event_id/organizers")
      );

      print(response.statusCode);

      if (response.statusCode == 200){
        var resp = jsonDecode(response.body);
        for(var o in resp["data"])
          organizers.add(o['id']);

        return organizers;
      }

      return organizers;
    }catch (e) {
      print(e);
      return [];
    }
  }

  static Future<User> getUser({String key = "object"}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var temp = await pref.getString(key);
    Map<String,dynamic> t = jsonDecode(temp ?? "");
    return User.fromJson(t);
  }
}