import 'dart:convert';

class Announcement {
  final String orgName;
  final String announcement;
  final DateTime createdAt;

  const Announcement ({
    required this.orgName,
    required this.announcement,
    required this.createdAt
  });


  String toJson() {
    return jsonEncode({
      'name': this.orgName,
      'announcement': this.announcement,
      'created_at': this.createdAt
    });
  }

  factory Announcement.fromJson(Map json) {
    return Announcement(
      orgName: json['name'],
      announcement: json['announcement'],
      createdAt: DateTime.parse(json['created_at'])
    );
  }
}