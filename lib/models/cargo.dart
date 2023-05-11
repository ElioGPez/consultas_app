import 'dart:convert';

List<Cargo> cargosFromJson(String str) =>
    List<Cargo>.from(json.decode(str).map((x) => Cargo.fromJson(x)));

class Cargo {
  late int id;
  late String nombre;
  late int nivelId;
  late String createdAt;
  late String updatedAt;

  Cargo(
      {required this.id,
      required this.nombre,
      required this.nivelId,
      required this.createdAt,
      required this.updatedAt});

  Cargo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    nivelId = json['nivel_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['nivel_id'] = nivelId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
