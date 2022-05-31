import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ticcket/core/res/app.dart';
import 'package:ticcket/models/event.dart';
// import 'package:http_parser/http_parser.dart';



class EventsController {
  static var client = http.Client();
  static Map<String,String> _headers = {
      "Accept": "application/json",
  };


  static Future<bool> delete(int event_id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var t = await pref.getString("object")!;
    String token = jsonDecode(t)['token'];

    try {
      _headers.addAll({"Authorization": "Bearer $token"});

      
      var response = await client.delete(
        headers: _headers,
        Uri.http(AppConstants.server, 'api/events/$event_id')
      );

      if(response.statusCode == 200)
        return true;

    }catch (e) {
      print(e);
    }

    return false;
  }

  static Future<dynamic> addEvent({required title, required description, required startAt, required endAt, required File logo}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var t = await pref.getString("object")!;
    String token = jsonDecode(t)['token'];

    Event? e;
    try {
      _headers.addAll({"Authorization": "Bearer $token"});

    print("$startAt   $endAt");

      var request = new http.MultipartRequest("POST", Uri.http(AppConstants.server, 'api/events'));
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['start_at'] = startAt;
      request.fields['end_at'] = endAt;
      request.headers.addAll(_headers);

      request.files.add(
        await http.MultipartFile.fromPath(
          'logo',
          logo.path,
        )
      );

      var response = await request.send();
      if (response.statusCode == 200){
        var resp = await response.stream.bytesToString();
        // print(resp);
        e = Event.fromJson(jsonDecode(resp)['data']);
      }
      return e;
    }catch (e) {
      print(e);
      return null;
    }
  }

  static Future<dynamic> getTopEvents() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var t = await pref.getString("object")!;
    String token = jsonDecode(t)['token'];

    List tEvents = [];
    try {
    _headers.addAll({"Authorization": "Bearer $token"});

    var response = await client.get(
      headers: _headers,
      Uri.http(AppConstants.server, 'api/events/e/top')
    );

    if (response.statusCode == 200){
      var resp = jsonDecode(response.body);
      for(Map e in resp['data'])
        tEvents.add(Event.fromJson(e));
    }

    return tEvents;
    }catch (e) {
      print(e);
      return null;
    }

  }

  static Future<dynamic> getAllEvent(int page_id) async {
    // http://178.62.201.95/api/events?page=1
    SharedPreferences pref = await SharedPreferences.getInstance();

    var t = await pref.getString("object")!;
    String token = jsonDecode(t)['token'];

    List events = [];
    try {
      _headers.addAll({"Authorization": "Bearer $token"});

      var response = await client.get(
        headers: _headers,
        Uri.http(AppConstants.server, "api/events", {
          "page": page_id.toString(),
        })
      );

      if (response.statusCode == 200){
      var resp = jsonDecode(response.body);
        for(var t in resp["data"])
          events.add(Event.fromJson(t));
      
        return [resp['last_page'], events];
      }

      return events;
    }catch (e) {
      print(e);
      return null;
    }
    
  }

  static Future<dynamic> getOrganizing() async {
    // http://178.62.201.95/api/events?page=1
    SharedPreferences pref = await SharedPreferences.getInstance();

    var t = await pref.getString("object")!;
    String token = jsonDecode(t)['token'];

    List events = [];
    try {
    _headers.addAll({"Authorization": "Bearer $token"});

    var response = await client.get(
      headers: _headers,
      Uri.http(AppConstants.server, "api/user/organize")
    );

    if (response.statusCode == 200){
      var resp = jsonDecode(response.body);
      for(var t in resp["data"])
        events.add(Event.fromJson(t));
    
      // print(events);
      return events;
    }else
      return null;

    }catch (e) {
      print(e);
      return null;
    }
    
  }

}