import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ticcket/core/res/app.dart';
import 'package:ticcket/models/ticket.dart';
import 'package:ticcket/models/user.dart';
import 'package:ticcket/services/global.dart';

class TicketsController {
    static var client = http.Client();
    static Map<String,String> _headers = {
        "Accept": "application/json",
    };


    static Future<dynamic> scannTicket(String tToken, int event_id) async {
      User u = await Global.getUser();

      User? user;
      try {
      _headers.addAll({"Authorization": "Bearer ${u.token}"});

      var response = await client.post(
        headers: _headers,
        body: {
          "ticket": tToken,
          "event_id": event_id.toString()
        },
        Uri.http(AppConstants.server, "api/organizers/scan")
      );

      print(response.body);

      if (response.statusCode == 200){
        var resp = jsonDecode(response.body)['data'];
        if (resp['user'] == "anonymous")
          return "anonymous";
        else
          return User.fromJson(resp['user']);
      }
      
      return user;
      }catch (e) {
        print(e);
        return null;
      }
      
    }

    static Future<dynamic> bookTicket(int eventId) async {
      User u = await Global.getUser();

      List? data;
      try {
        _headers.addAll({"Authorization": "Bearer ${u.token}"});

        var response = await client.post(
          headers: _headers,
          body: {
            "user_id": u.id.toString(),
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

        // print(response.body);

        return data;
      }catch (e) {
        print(e);
        return null;
      }
    }

    static Future<dynamic> getUserTickets() async {
    User u = await Global.getUser();

    List ticket = [];
    try {
    _headers.addAll({"Authorization": "Bearer ${u.token}"});

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