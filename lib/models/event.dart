import 'dart:convert';

class Event {
  final int id;
  final String title;
  final String? description;
  final String? logo;
  final String? startAt;
  final String? endAt;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.logo,
    required this.startAt,
    required this.endAt,
  });

  String toJson() {
    return jsonEncode({
      "id": this.id,
      "title": this.title,
      "description": this.description,
      "logo": this.logo,
      "start_at": this.startAt,
      "end_at": this.endAt,
    });
  }

  factory Event.fromJson(Map json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      logo: json['logo'],
      startAt: json['start_at'],
      endAt: json['end_at'],
    );
  }

}