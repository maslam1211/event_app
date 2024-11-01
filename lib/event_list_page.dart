
import 'package:event_app1/screens/event_detail_page.dart';
import 'package:event_app1/model/event_model.dart';
import 'package:flutter/material.dart';

class EventListPage extends StatelessWidget {
  final List<Event> events = [
    Event(
      title: "Tech Conference",
      date: "2024-11-15",
      description: "A conference on the latest in technology.",
      attendees: [],
    ),
    Event(
      title: "Music Festival",
      date: "2024-12-01",
      description: "An outdoor music festival.",
      attendees: [],
    ),
    Event(
      title: "Dance Festival",
      date: "2024-12-01",
      description: "An indoor dance festival.",
      attendees: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(event.title),
                subtitle: Text("${event.date}\n${event.description}"),
                isThreeLine: true,
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    EventDetailPage(event: event),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin =
                                  Offset(1.0, 0.0); // Slide in from the right
                              var end = Offset.zero;
                              var curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ));
                    },
                    child: Text('RSVP'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
