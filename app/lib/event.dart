class Event {
  final String? id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String course;
  final String description;
  final double latitude;
  final double longitude;
  final String professor;
  final String professorEmail;
  final String monitor;
  final String monitorEmail;

  Event({
    this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.course,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.professor,
    required this.professorEmail,
    required this.monitor,
    required this.monitorEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'time': time,
      'location': location,
      'course': course,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'professor': professor,
      'professorEmail': professorEmail,
      'monitor': monitor,
      'monitorEmail':monitorEmail,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      time: map['time'],
      location: map['location'],
      course: map['course'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      professor: map['professor'],
      professorEmail: map['professorEmail'],
      monitor: map['monitor'],
      monitorEmail: map['monitorEmail'],
    );
  }
}
