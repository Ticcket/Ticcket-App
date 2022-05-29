import 'package:http/http.dart' as http;
import 'package:ticcket/core/res/app.dart';

class Auth {
  var client = http.Client();
  var url = Uri.parse('${AppConstants.server}api/register');


  login() {
      var response = await client.post(
      Uri.https('example.com', 'whatsit/create'),
      body: {'name': 'doodle', 'color': 'blue'});
  }

}