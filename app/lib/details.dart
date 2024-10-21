import 'package:flutter/material.dart';
import 'event.dart';
import 'edit_event.dart';
import 'usuario.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;
  final Usuario user;

  const EventDetailsPage({Key? key, required this.event, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 225, 230, 232),
        centerTitle: true,
        actions: [
          IconButton(
            color: Color.fromARGB(255, 0, 130, 35),
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
        title: Image.asset(
          'images/logo.png',
          height: 50,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 225, 230, 232),
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 217, 217, 217),
                borderRadius: BorderRadius.circular(25),
              ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Text(
              //       '📍 Localização',
              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //     ),
              //     Text(
              //       '🕒 Turno',
              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //     ),
              //     Text(
              //       '📑 Modalidade',
              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                // Title and Date-Time Row
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '${event.date} - ${event.time}',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25), // Adjusted spacing
                buildSection('Localização: ', event.location),
                SizedBox(height: 30),
                buildSection('Curso: ', event.course),
                SizedBox(height: 35),
                buildSection('Resumo: ', event.description),
                SizedBox(height: 40),
                buildSection('Professor: ', event.professor),
                SizedBox(height: 45),
                buildSection('Email do professor: ', event.professorEmail),
                SizedBox(height: 50),
                buildSection('Monitor: ', event.monitor),
                SizedBox(height: 55),
                buildSection('Email do monitor: ', event.monitorEmail),
                SizedBox(height: 110),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (event.professorId == user.id || event.monitorEmail == user.email)
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditEventPage(event, user),
                                ),
                              );
                            }
                          : null,
                      child: Text('Editar', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Retornar', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSection(String title, String content) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: content,
            style: TextStyle(fontSize: 14.0, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
