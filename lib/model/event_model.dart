
class Attendee {
  final String name;
  final String email;

  Attendee({required this.name, required this.email});
}

class Event {
  final String title;
  final String date;
  final String description;
  final List<Attendee> attendees;

  Event({
    required this.title,
    required this.date,
    required this.description,
    this.attendees = const [],
  });
}
