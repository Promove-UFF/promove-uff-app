import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_uff/usuario.dart';
import 'event.dart';
import 'database/db.dart';
import 'interface.dart';

class LocationPickerScreen extends StatefulWidget {
  final Event event;
  final Usuario user;

  LocationPickerScreen(this.event, this.user);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    if (widget.event.latitude != 0.0 && widget.event.longitude != 0.0) {
      _selectedLocation = LatLng(widget.event.latitude, widget.event.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha o Local do Evento'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              if (_selectedLocation != null) {
                final updatedEvent = Event(
                  id: widget.event.id,
                  title: widget.event.title,
                  date: widget.event.date,
                  time: widget.event.time,
                  location: widget.event.location,
                  course: widget.event.course,
                  description: widget.event.description,
                  latitude: _selectedLocation!.latitude,
                  longitude: _selectedLocation!.longitude,
                  professor: widget.event.professor,
                  professorEmail: widget.event.professorEmail,
                  monitor: widget.event.monitor,
                  monitorEmail: widget.event.monitorEmail,
                );
                if(widget.event.id == null){
                await DB.instance.insertEvent(updatedEvent);
                }
                else{
                  await DB.instance.updateEvent(updatedEvent);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InterfacePage(widget.user),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Por favor, selecione um local no mapa.')),
                );
              }
            },
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _selectedLocation ?? LatLng(-22.9056, -43.1344),
          initialZoom: 15.0,
          onTap: (tapPosition, point) {
            setState(() {
              _selectedLocation = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          if (_selectedLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: _selectedLocation!,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40.0,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

