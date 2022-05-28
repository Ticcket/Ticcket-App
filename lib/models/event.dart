import 'package:intl/intl.dart';

class Event {
  final String title;
  final String description;
  final String logo;
  final String startAt;
  final String endAt;

  const Event({
    required this.title,
    required this.description,
    required this.logo,
    required this.startAt,
    required this.endAt,
  });
}

// ignore: non_constant_identifier_names
List<Event> demo_events = [
  Event(title: "Techne Summit", description: "this is an event", logo: "http://178.62.201.95/storage/events/1653069980-turing_point.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 2 fkldjflaf kljdlkjalkfd", description: "this is an event", logo: "http://178.62.201.95/storage/events/1653069980-turing_point.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 3", description: "this is an event", logo: "http://178.62.201.95/storage/events/1653069980-turing_point.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
];