import 'dart:convert';

List<Consulta> consultaFromJson(String str) => List<Consulta>.from(json.decode(str).map((x) => Consulta.fromJson(x)));


class Consulta {
  final Vacante? vacante;
  final VacanteDetalle? vacanteDetalle;
  final List<Padrones>? padrones;

  Consulta({
    this.vacante,
    this.vacanteDetalle,
    this.padrones,
  });

  Consulta.fromJson(Map<String, dynamic> json)
    : vacante = (json['vacante'] as Map<String,dynamic>?) != null ? Vacante.fromJson(json['vacante'] as Map<String,dynamic>) : null,
      vacanteDetalle = (json['vacante_detalle'] as Map<String,dynamic>?) != null ? VacanteDetalle.fromJson(json['vacante_detalle'] as Map<String,dynamic>) : null,
      padrones = (json['padrones'] as List?)?.map((dynamic e) => Padrones.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'vacante' : vacante?.toJson(),
    'vacante_detalle' : vacanteDetalle?.toJson(),
    'padrones' : padrones?.map((e) => e.toJson()).toList()
  };
}

class Vacante {
  final int? id;
  final String? codigo;
  final String? caracter;
  final String? fechaPublicacionInicio;
  final String? fechaPublicacionFin;
  final String? cargos;
  final bool? abierto;

  Vacante({
    this.id,
    this.codigo,
    this.caracter,
    this.fechaPublicacionInicio,
    this.fechaPublicacionFin,
    this.cargos,
    this.abierto,
  });

  Vacante.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      codigo = json['codigo'] as String?,
      caracter = json['caracter'] as String?,
      fechaPublicacionInicio = json['fechaPublicacionInicio'] as String?,
      fechaPublicacionFin = json['fechaPublicacionFin'] as String?,
      cargos = json['cargos'] as String?,
      abierto = json['abierto'] as bool?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'codigo' : codigo,
    'caracter' : caracter,
    'fechaPublicacionInicio' : fechaPublicacionInicio,
    'fechaPublicacionFin' : fechaPublicacionFin,
    'cargos' : cargos,
    'abierto' : abierto
  };
}

class VacanteDetalle {
  final int? id;
  final String? codigo;
  final String? fechaPublicacionInicio;
  final String? fechaPublicacionFin;
  final String? fechaDesignacion;
  final String? descripcion;
  final int? estadoId;
  final String? designado;

  VacanteDetalle({
    this.id,
    this.codigo,
    this.fechaPublicacionInicio,
    this.fechaPublicacionFin,
    this.fechaDesignacion,
    this.descripcion,
    this.estadoId,
    this.designado,
  });

  VacanteDetalle.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      codigo = json['codigo'] as String?,
      fechaPublicacionInicio = json['fechaPublicacionInicio'] as String?,
      fechaPublicacionFin = json['fechaPublicacionFin'] as String?,
      fechaDesignacion = json['fechaDesignacion'] as String?,
      descripcion = json['descripcion'] as String?,
      estadoId = json['estadoId'] as int?,
      designado = json['designado'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'codigo' : codigo,
    'fechaPublicacionInicio' : fechaPublicacionInicio,
    'fechaPublicacionFin' : fechaPublicacionFin,
    'fechaDesignacion' : fechaDesignacion,
    'descripcion' : descripcion,
    'estadoId' : estadoId,
    'designado' : designado
  };
}

class Padrones {
  final int? pedidoCoberturaPadronId;
  final dynamic prioridad;
  final String? convocatoria;
  final String? organizacion;
  final String? nivel;
  final String? cargo;
  final String? asignatura;
  final String? especialidad;
  final String? conCargo;
  final String? url;

  Padrones({
    this.pedidoCoberturaPadronId,
    this.prioridad,
    this.convocatoria,
    this.organizacion,
    this.nivel,
    this.cargo,
    this.asignatura,
    this.especialidad,
    this.conCargo,
    this.url,
  });

  Padrones.fromJson(Map<String, dynamic> json)
    : pedidoCoberturaPadronId = json['PedidoCoberturaPadronId'] as int?,
      prioridad = json['Prioridad'],
      convocatoria = json['Convocatoria'] as String?,
      organizacion = json['Organizacion'] as String?,
      nivel = json['Nivel'] as String?,
      cargo = json['Cargo'] as String?,
      asignatura = json['Asignatura'] as String?,
      especialidad = json['Especialidad'] as String?,
      conCargo = json['ConCargo'] as String?,
      url = json['Url'] as String?;

  Map<String, dynamic> toJson() => {
    'PedidoCoberturaPadronId' : pedidoCoberturaPadronId,
    'Prioridad' : prioridad,
    'Convocatoria' : convocatoria,
    'Organizacion' : organizacion,
    'Nivel' : nivel,
    'Cargo' : cargo,
    'Asignatura' : asignatura,
    'Especialidad' : especialidad,
    'ConCargo' : conCargo,
    'Url' : url
  };
}