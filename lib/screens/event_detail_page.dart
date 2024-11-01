import 'package:event_app1/api/event_api.dart';
import 'package:event_app1/model/event_model.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;

  EventDetailPage({required this.event});

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  String name = '';
  String email = '';
  bool isLoading = false;

  Future<void> _rsvp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      // Simulate API call
      final success = await _apiService.signUpForEvent(name, email);
      setState(() => isLoading = false);

      if (success) {
        setState(() {
          widget.event.attendees.add(Attendee(name: name, email: email));
      
          name = '';
          email = '';
         
          _formKey.currentState!.reset();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('RSVP successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('RSVP failed. Try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: SingleChildScrollView(
        
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.event.date, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(widget.event.description),
              Divider(),
              // Form section first
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RSVP to this event:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 3, bottom: 12),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Name', border: InputBorder.none),
                          onChanged: (value) => name = value,
                          validator: (value) =>
                              value!.isEmpty ? 'Enter your name' : null,
                        ),
                      ),
                    ),
                    Divider(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 3, bottom: 12),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email', border: InputBorder.none),
                          onChanged: (value) => email = value,
                          validator: (value) => value!.contains('@')
                              ? null
                              : 'Enter a valid email',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: _rsvp,
                            child: Text('Submit RSVP'),
                          ),
                  ],
                ),
              ),
              Divider(),
              // Attendee list section
              Text('Attendees:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              widget.event.attendees.isEmpty
                  ? Text('No attendees yet.')
                  : ListView.builder(
                      shrinkWrap:
                          true, 
                      physics:
                          NeverScrollableScrollPhysics(), 
                      itemCount: widget.event.attendees.length,
                      itemBuilder: (context, index) {
                        final attendee = widget.event.attendees[index];
                        return Card(
                          child: ListTile(
                            title: Text(attendee.name),
                            subtitle: Text(attendee.email),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
