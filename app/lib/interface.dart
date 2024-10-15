import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart'; // Adicione essa linha
import 'package:project_uff/details.dart';
import 'event.dart';

import 'database/db.dart';
import 'edit_event.dart';
import 'usuario.dart';

class InterfacePage extends StatefulWidget {
  final Usuario user;

  InterfacePage(this.user);

  @override
  _InterfacePageState createState() => _InterfacePageState();
}

class _InterfacePageState extends State<InterfacePage> {
  late DB _databaseHelper;
  late List<Event> events;
  Event? _selectedEvent;
  LatLng? _currentLocation; // Variável para armazenar a localização atual

  @override
  void initState() {
    super.initState();
    _databaseHelper = DB.instance;
    events = [];
    _loadEvents();
    _requestLocation(); // Solicitar localização ao iniciar
  }

  // Método para carregar eventos do banco de dados
  Future<void> _loadEvents() async {
    final _events = await _databaseHelper.getEventList();
    setState(() {
      events = _events;
    });
  }

  // Método para solicitar permissão e pegar a localização do usuário
  Future<void> _requestLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Caso o serviço esteja desativado
      return;
    }

    // Verifica a permissão de localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissão negada, não faz nada
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissão permanentemente negada, não pode pedir novamente
      return;
    }

    // Se a permissão foi concedida, pega a localização atual
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 225, 230, 232),
        centerTitle: true,
        actions: [
          IconButton(
            color: Color.fromARGB(255, 0, 130, 35),
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
          if (widget.user.isProfessor) // É professor?
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
                  professorId: '',
                  monitor: '',
                  monitorEmail: '',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditEventPage(novoEvento, widget.user),
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
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                // Ajusta o centro para a localização atual se disponível, caso contrário, usa um valor padrão, no nosso caso, a UFF Praia vermelha, podendo ser alterado.
                initialCenter: _currentLocation ?? LatLng(-22.9056, -43.1344), 
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
              ],
            ),
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
                                  builder: (context) => EventDetailsPage(event: _selectedEvent!, user: widget.user),
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
