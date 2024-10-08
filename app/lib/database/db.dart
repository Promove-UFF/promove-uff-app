import 'package:cloud_firestore/cloud_firestore.dart';
import '../event.dart';

class DB {
  DB._();

  static final DB instance = DB._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _eventsCollection => _firestore.collection('events');

  Future<void> insertEvent(Event event) async {
    await _eventsCollection.add(event.toMap());
  }

  // Future<List<Event>> getEventList() async {
  //   QuerySnapshot snapshot = await _eventsCollection.get();
  //   return snapshot.docs
  //       .map((doc) => Event.fromMap(doc.data() as Map<String, dynamic>))
  //       .toList();
  // }
  // gambiarra para o id
  Future<List<Event>> getEventList() async {
    QuerySnapshot snapshot = await _eventsCollection.get();
    return snapshot.docs.map((doc) {
      // Adicionando o ID do documento ao mapa antes de criar o objeto Event
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return Event.fromMap(data);
    }).toList();
  }



  Future<void> updateEvent(Event event) async {
    await _eventsCollection.doc(event.id).update(event.toMap());
  }
  Future<void> deleteEvent(String id) async {
    await _eventsCollection.doc(id).delete();
  }
}
