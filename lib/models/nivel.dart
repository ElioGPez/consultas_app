
import 'dart:convert';

List<Nivel> nivelsFromJson(String str) => List<Nivel>.from(json.decode(str).map((x) => Nivel.fromJson(x)));

class Nivel {
  late int id;
  late String nombre;
  late String createdAt;
  late String updatedAt;

  Nivel({required this.id, required this.nombre, required this.createdAt, required this.updatedAt});

  Nivel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}