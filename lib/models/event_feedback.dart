import 'dart:convert';

class EventFeedback {

  final int id;
  final double rating;
  final String? comment;
  final int user_id;
  final int event_id;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EventFeedback({
    required this.id,
    required this.rating,
    required this.comment,
    required this.user_id,
    required this.event_id,
    required this.createdAt,
    required this.updatedAt
  });

  String toJson() {
    return jsonEncode({
      "id": this.id,
      "rating": this.rating,
      "comment": this.comment,
      "user_id": this.user_id,
      "event_id": this.event_id,
      "created_at": this.createdAt,
      "updated_at": this.updatedAt
    });
  }
  
  factory EventFeedback.fromJson(json) {
    return EventFeedback(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      user_id: json['user_id'],
      event_id: json['event_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at'])
    );
  }
}