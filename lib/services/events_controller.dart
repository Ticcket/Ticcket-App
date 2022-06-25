import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ticcket/core/res/app.dart';
import 'package:ticcket/models/event.dart';
import 'package:ticcket/models/user.dart';
import 'package:ticcket/services/global.dart';
// import 'package:http_parser/http_parser.dart';

class EventsController {
  static var client = http.Client();
  static Map<String,String> _headers = {
      "Accept": "application/json",
  };


  static Future<List> searchUsers({String? name, String? email, int? limit}) async {
    User user = await Global.getUser();
    
    List us = [];
    Map<String, dynamic> body = {};
    try {
      _headers.addAll({"Authorization": "Bearer ${user.token}"});

      if(name != null && name.isNotEmpty)
        body.addAll({"name": name});
      else if(email != null && email.isNotEmpty)
        body.addAll({"email": email});
      
      if(limit != null)
        body.addAll({'limit': limit});

      var response = await client.get(
        headers: _headers,
        Uri.http(AppConstants.server, "api/user/search", body)
      );

      // print(response.body);

      if(response.statusCode == 200) {
        var resp = jsonDecode(response.body)['data'];
        for(var u in resp['result'])
          us.add(User.fromJson(u));
      }
      // print(us);
    }catch (e) {
      print(e);
    }
  
    return us;
  }

  static Future<Map> addOrganizer(String user_email, int event_id) async {
    User user = await Global.getUser();
    Map result = {};
    try {
      _headers.addAll({"Authorization": "Bearer ${user.token}"});
      
      var response = await client.post(
        headers: _headers,
        body: {
          "user_email": user_email,
          'event_id': event_id.toString()
        },
        Uri.http(AppConstants.server, "api/organizers")
      );

      if(response.statusCode == 200) {
        result = jsonDecode(response.body)['data'];
      }


    }catch(e) {
      print(e);
    }

    return result;
  }

  static Future<List> getOrganizers(int event_id) async {
    User user = await Global.getUser();
    List orgs = [];
    try {
      _headers.addAll({"Authorization": "Bearer ${user.token}"});
      
      var response = await client.get(
        headers: _headers,
        Uri.http(AppConstants.server, "api/events/$event_id/organizers")
      );

      if(response.statusCode == 200) {
        var resp = jsonDecode(response.body)['data'];
        for(var u in resp)
          orgs.add(User.fromJson(u));
      }


    }catch(e) {
      print(e);
    }

    return orgs;
  }


  static Future<bool> delete(int event_id) async {
    User user = await Global.getUser();

    try {
      _headers.addAll({"Authorization": "Bearer ${user.token}"});

      
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
    User user = await Global.getUser();

    Event? e;
    try {
      _headers.addAll({"Authorization": "Bearer ${user.token}"});

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
    User user = await Global.getUser();

    List tEvents = [];
    try {
    _headers.addAll({"Authorization": "Bearer ${user.token}"});

    var response = await client.get(
      headers: _headers,
      Uri.http(AppConstants.server, 'api/events/e/top')
    );

    if (response.statusCode == 200){
      var resp = jsonDecode(response.body);
      for(Map e in resp['data']){
        e['rating'] = e['rating'].toDouble();
        tEvents.add(Event.fromJson(e));
      }
    }

    return tEvents;
    }catch (e) {
      print(e);
      return null;
    }

  }

  static Future<dynamic> getAllEvent(int page_id) async {
    // http://178.62.201.95/api/events?page=1
    User user = await Global.getUser();
    
    List events = [];
    try {
      _headers.addAll({"Authorization": "Bearer ${user.token}"});
      var response = await client.get(
        headers: _headers,
        Uri.http(AppConstants.server, "api/events", {
          "page": page_id.toString(),
        })
      );

      if (response.statusCode == 200){
      var resp = jsonDecode(response.body);
        for(Map t in resp["data"]){
          t['rating'] = t['rating'] != null ? double.parse(t['rating']) : null;
          // print(t);
          events.add(Event.fromJson(t));
        }
      
        return [resp['last_page'], events];
      }

      return events;
    }catch (e) {
      print(e);
      return null;
    }
    
  }

  static Future<dynamic> getOrganizing() async {
    User user = await Global.getUser();

    List events = [];
    try {
    _headers.addAll({"Authorization": "Bearer ${user.token}"});

    var response = await client.get(
      headers: _headers,
      Uri.http(AppConstants.server, "api/user/organize")
    );

    if (response.statusCode == 200){
      var resp = jsonDecode(response.body);
      print(resp);
      for(Map t in resp["data"]){
        t['rating'] = t['rating'] != null ? double.parse(t['rating']) : null;
        print(t);
        events.add(Event.fromJson(t));
      }
    
      // print(events);
      return events;
    }else
      return null;

    }catch (e) {
      print(e);
      return null;
    }
    
  }

  static Future<dynamic> getOwned() async {
    User user = await Global.getUser();

    List events = [];
    try {
    _headers.addAll({"Authorization": "Bearer ${user.token}"});

    var response = await client.get(
      headers: _headers,
      Uri.http(AppConstants.server, "api/user/events")
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