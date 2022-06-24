import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ticcket/core/res/app.dart';
import 'package:ticcket/models/announcement.dart';
import 'package:ticcket/models/user.dart';
import 'package:ticcket/services/global.dart';

class AnnouncementsController {
  static var client = http.Client();
  static Map<String,String> _headers = {
      "Accept": "application/json",
  };

  static Future<bool> addAnnouncement(String message, int event_id) async {
    User user = await Global.getUser();

    try {
      _headers.addAll({"Authorization": "Bearer ${user.token}"});

      var response = await client.post(
        headers: _headers,
        body: {
          "message": message,
          "event_id": event_id.toString(),
        },
        Uri.http(AppConstants.server, 'api/organizers/announcement')
      );

      print(response.body);

      if(response.statusCode == 200)
        return true;

    }catch (e) {
      print(e);
    }

    return false;
  }

  static Future<List> getAllAnnouncements(int event_id) async{
    User user = await Global.getUser();
    List anns = [];
    try {
      _headers.addAll({"Authorization": "Bearer ${user.token}"});


      var response = await client.get(
        headers: _headers,
        Uri.http(AppConstants.server, 'api/events/$event_id/announcements')
      );
      print(response.body);
      if (response.statusCode == 200) {
        var resp = jsonDecode(response.body)['data'];
        for (var a in resp) {
          anns.add(Announcement.fromJson(a));
        }
      }

      return anns;
    }catch(e) {
      print(e);
    }

    return anns;
  }
}