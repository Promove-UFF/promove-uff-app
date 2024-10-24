class Usuario {
  final String id;
  final String nome;
  final String email;
  final String? fotoUrl;
  final bool isProfessor;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    this.fotoUrl,
    required this.isProfessor,
  });

  factory Usuario.fromFirestore(Map<String, dynamic> data, String id) {
    return Usuario(
      id: id,
      nome: data['name'] ?? '',
      email: data['email'] ?? '',
      fotoUrl: data['photoUrl'],
      isProfessor: data['isProfessor'],
    );
  }
  factory Usuario.visitante() {
    return Usuario(
      id: 'visitante_id', 
      email: 'visitante@exemplo.com', 
      nome: 'Visitante',
      isProfessor: false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': nome,
      'email': email,
      'photoUrl': fotoUrl,
      'isProfessor': isProfessor, 
    };
  }

}
