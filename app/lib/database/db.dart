import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../event.dart';

class DB {
  DB._();

  static final DB instance = DB._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    return await _initDatabase();
  }


  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'infos.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  _onCreate(db, version) async {
    await db.execute('''
    CREATE TABLE usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      email TEXT,
      senha TEXT,
      curso TEXT,
      tipo INTEGER
    )
    ''');
    await db.execute(
        'CREATE TABLE events_table(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, time TEXT, location TEXT, course TEXT, description TEXT, latitude REAL, longitude REAL, professor TEXT, professorEmail TEXT, monitor TEXT, monitorEmail TEXT)');
  }

  Future<List<Map<String, Object?>>> getUsuarios() async {
    final db = await database;
    final data = await db.query('usuarios');
    return data;
  }

  void setUsuarios(
      String nome, String email, String senha, String curso, int tipo) async {
    final db = await database;
    await db.insert('usuarios', {
      'nome': nome,
      'email': email,
      'senha': senha,
      'curso': curso,
      'tipo': tipo
    });
  }

  Future<List<Map<String, dynamic>>> getEventMapList() async {
    final db = await database;
    final result = await db.query('events_table');
    return result;
  }

  Future<List<Event>> getEventList() async {
    final List<Map<String, dynamic>> eventMapList = await getEventMapList();
    final List<Event> eventList = [];
    eventMapList.forEach((eventMap) {
      eventList.add(Event.fromMap(eventMap));
    });
    return eventList;
  }

  Future<int> insertEvent(Event event) async {
    Database db = await database;
    print(event.toMap());
    final int result = await db.insert('events_table', event.toMap());
    return result;
  }

  Future<int> updateEvent(Event event) async {
    Database db = await database;
    final int result = await db.update(
      'events_table',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
    return result;
  }

  Future<int> deleteEvent(int id) async {
    Database db = await database;
    final int result = await db.delete(
      'events_table',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }
}
