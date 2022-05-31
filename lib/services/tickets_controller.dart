import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ticcket/core/res/app.dart';
import 'package:ticcket/models/ticket.dart';
import 'package:ticcket/models/user.dart';

class TicketsController {
    static var client = http.Client();
    static Map<String,String> _headers = {
        "Accept": "application/json",
    };


    static Future<dynamic> scannTicket(String token, int event_id) async {
      // http://178.62.201.95/api/events?page=1
      SharedPreferences pref = await SharedPreferences.getInstance();

      var t = await pref.getString("object")!;
      String token = jsonDecode(t)['token'];

      User? user;
      try {
      _headers.addAll({"Authorization": "Bearer $token"});

      var response = await client.post(
        headers: _headers,
        body: {
          "ticket": token,
          "event_id": event_id
        },
        Uri.http(AppConstants.server, "api/organizers/scan")
      );

      if (response.statusCode == 200){
        var resp = jsonDecode(response.body);
        user = User.fromJson(resp['user']);
      }
      
      return user;
      }catch (e) {
        print(e);
        return null;
      }
      
    }

    static Future<dynamic> bookTicket(int eventId) async {
      SharedPreferences pref = await SharedPreferences.getInstance();

      var t = await pref.getString("object")!;
      Map user = jsonDecode(t);

      List? data;
      try {

        var response = await client.post(
          headers: _headers,
          body: {
            "user_id": user["id"].toString(),
            "event_id": eventId.toString()
          },
          Uri.http(AppConstants.server, "api/tickets")
        );

        if(response.statusCode == 200)
          data = [true, jsonDecode(response.body)];
        if(response.statusCode == 409)
          data = [false, jsonDecode(response.body)];
        else if (response.statusCode == 422)
          data = [false, jsonDecode(response.body)];
        else
          data = null;

        return data;
      }catch (e) {
        print(e);
        return null;
      }
    }

    static Future<dynamic> getUserTickets() async {
    // http://178.62.201.95/api/events?page=1
    SharedPreferences pref = await SharedPreferences.getInstance();

    var t = await pref.getString("object")!;
    String token = jsonDecode(t)['token'];

    List ticket = [];
    try {
    _headers.addAll({"Authorization": "Bearer $token"});

    var response = await client.get(
      headers: _headers,
      Uri.http(AppConstants.server, "api/user/tickets")
    );

    if (response.statusCode == 200){
      var resp = jsonDecode(response.body);
      // print(resp);
      for(Map t in resp["data"])
        ticket.add(Ticket.fromJsonShow(t));
    }
    
    return ticket;
    }catch (e) {
      print(e);
      return null;
    }
    
  }
}