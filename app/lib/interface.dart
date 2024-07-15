import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_uff/details.dart';
import 'event.dart';
import 'database/db.dart';
import 'edit_event.dart';

class InterfacePage extends StatefulWidget {
  final int? tipo; // Declare tipo como final

  InterfacePage(this.tipo);

  @override
  _InterfacePageState createState() => _InterfacePageState();
}

class _InterfacePageState extends State<InterfacePage> {
  late DB _databaseHelper;
  late List<Event> events;
  Event? _selectedEvent;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DB.instance;
    events = [];
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final _events = await _databaseHelper.getEventList();
    setState(() {
      events = _events;
    });
  }

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
          if (widget.tipo == 0) // Verifique o valor de tipo aqui
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Event novoEvento = Event(
                  id: null,
                  title: '',
                  date: '',
                  time: '',
                  location: '',
                  course: '',
                  description: '',
                  latitude: 0.0,
                  longitude: 0.0,
                  professor: '',
                  professorEmail: '',
                  monitor: '',
                  monitorEmail: '',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditEventPage(novoEvento),
                  ),
                );
              },
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('📍 Localização',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('🕒 Turno',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('📑 Modalidade',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Expanded(
            child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(-22.9056, -43.1344), // Centro do mapa (Exemplo: UFF, Niterói)
                  initialZoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: events.map((event) {
                      return Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(event.latitude, event.longitude),
                        child: GestureDetector(
                          onTap: () {
                            _showMarkerInfo(context, event);
                          },
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40.0,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ]),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(16.0),
            height: 220, // Definindo altura fixa
            child: _selectedEvent != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.purple),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedEvent!.title!,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  _selectedEvent!.date!,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.purple),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Localização: ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: _selectedEvent!.location!,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Curso: ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: _selectedEvent!.course!,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Expanded(
                        child: Text(
                          'Resumo: ${_selectedEvent!.description}',
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventDetailsPage(event: _selectedEvent!),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Detalhes',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'Selecione um evento',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _showMarkerInfo(BuildContext context, Event event) {
    setState(() {
      _selectedEvent = event;
    });
  }
}
