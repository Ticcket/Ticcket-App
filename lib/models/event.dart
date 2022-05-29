import 'package:intl/intl.dart';
import '../core/res/app.dart';

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
  Event(title: "Techne Summit", description: "this is an event", logo: "http://${AppConstants.server}/storage/events/1653069980-turing_point.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 2 fkldjflaf kljdlkjalkfd", description: "this is an event", logo: "http://${AppConstants.server}/storage/events/1653069980-turing_point.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 3", description: "this is an event", logo: "http://${AppConstants.server}/storage/events/1653069980-turing_point.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 3", description: "this is an event", logo: "http://${AppConstants.server}/storage/events/1653667503-ticcket_launch.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 3", description: "this is an event", logo: "http://${AppConstants.server}/storage/events/1653069980-turing_point.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 3", description: "this is an event", logo: "http://${AppConstants.server}/storage/events/1653069980-turing_point.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 3", description: "this is an event", logo: "http://${AppConstants.server}/storage/events/1653294320-event_gamed.jpg", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 3", description: "this is an event", logo: "http://${AppConstants.server}/storage/events/1653069980-turing_point.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 3", description: "this is an event", logo: "http://${AppConstants.server}/storage/events/1653069980-turing_point.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 3", description: "this is an event", logo: "http://${AppConstants.server}/storage/events/1653294320-event_gamed.jpg", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
  Event(title: "Techne Summit 3", description: "this is an event", logo: "http://${AppConstants.server}/storage/events/1653069980-turing_point.png", startAt: DateFormat.yMMM().format(DateTime(2022)), endAt: DateFormat.yMMM().format(DateTime(2022))),
];