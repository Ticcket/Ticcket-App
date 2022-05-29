/*
{
    "success": true,
    "message": "Ticket Created Successfully",
    "data": {
        "user_id": 1,
        "event_id": 1,
        "token": "eUZfmftWiP",
        "id": 1,
        "url": "https:\/\/chart.googleapis.com\/chart?chs=300x300&cht=qr&chl=eUZfmftWiP&choe=UTF-8",
        "user": {
            "id": 1,
            "name": "kemoo",
            "email": "kemoo@kareem.com",
            "email_verified_at": null,
            "photo": null,
            "created_at": "2022-05-20T18:05:43.000000Z",
            "updated_at": "2022-05-25T19:54:47.000000Z"
        },
        "event": {
            "id": 1,
            "title": "Turing Point",
            "description": "Turing Point Conference",
            "logo": "storage\/events\/1653069980-turing_point.png",
            "creator": 1,
            "start_at": "2022-05-21",
            "end_at": "2022-10-01"
        }
    }
}
*/
import '../core/res/app.dart';

class Ticket {
  final String token;
  final String qrCode;
  final String userEmail;
  final String eventTitle;
  final String eventLogo;

  Ticket({
    required this.token,
    required this.qrCode,
    required this.userEmail,
    required this.eventTitle,
    required this.eventLogo,
  });
}


List<Ticket> demo_tickets = [
  Ticket(token: "eUZfmftWiP", qrCode: "https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=eUZfmftWiP&choe=UTF-8", userEmail: "kemoo@kareem.com", eventTitle: "Technne Summit", eventLogo: "${AppConstants.server}storage/events/1653069980-turing_point.png")
];