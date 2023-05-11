import 'dart:convert';
import 'dart:io';

import 'package:consulta_app/models/cargo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/nivel.dart';
import '../utils/values_host.dart';

class NewPreefrences extends StatefulWidget {
  const NewPreefrences({super.key});
  @override
  State<NewPreefrences> createState() => _NewPreefrencesState();
}

class _NewPreefrencesState extends State<NewPreefrences> {
  @override
  Widget build(BuildContext context) {
    Future<List<Nivel>> getNivels() async {
      try {
        final resp = await http
            .get(Uri.parse('${ValuesGlobal.urlBase}getNivel'), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

        return nivelsFromJson(resp.body);
      } on SocketException {
        //Mjs de error para problemas de conexión
        throw Exception('Error de conexion');
      } catch (e) {
        throw Exception(e);
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Nueva Preferencia"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: FutureBuilder(
            future: getNivels(),
            builder: (context, AsyncSnapshot<List<Nivel>> snapshot) {
              //Mientras la respuesta este en espera, el circulo de carga permanece en la pantalla
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          tooltip: 'Actualizar',
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const NewPreefrences()));
                          },
                        ),
                      ],
                    ),
                  );
                }

                return Form(snapshot.data!);
              }

              // By default, show a loading spinner.
            }));
  }
}

class Form extends StatefulWidget {
  late List<Nivel> nivels;

  Form(
    this.nivels, {
    Key? key,
  }) : super(key: key);

  @override
  State<Form> createState() => _FormState(nivels);
}

class _FormState extends State<Form> {
  late Nivel nivel;
  late List<Cargo> cargos = [];
  late Cargo cargo =
      Cargo(id: 0, nombre: '', createdAt: '', nivelId: 0, updatedAt: '');
  late List<Map> circuitos = [
    {
      "name": 'Circuito I',
      "value": 'I',
    },
    {
      "name": 'Circuito II',
      "value": 'II',
    }
  ];
  late Map circuito = circuitos[0];
  late List<String> circuitosSelected = [];

  _FormState(List<Nivel> nivels) {
    nivel = (nivels.isNotEmpty
        ? nivels[0]
        : Nivel(id: 0, nombre: 'Sin datos', createdAt: '', updatedAt: ''));
    nivels.insert(
        0,
        Nivel(
            id: 0,
            nombre: 'Seleccione el nivel...',
            createdAt: '',
            updatedAt: ''));
    nivel = nivels[0];
    // this.auditoria = deposits.audit[0];
  }

  @override
  Widget build(BuildContext context) {
    //Definicion de controladores para los campos
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          height: 50,
          color: const Color.fromARGB(255, 207, 207, 207),
          child: const Center(
            child: Text(
              'Seleccione las opciones:',
              style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 19, 19, 19),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 30),
        /*Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '   Nivel',
              style: TextStyle(color: Colors.blue[400]),
            )),*/
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              labelText: 'Nivel',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            child: DropdownButton<Nivel>(
              isExpanded: true,
              value: nivel,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              //style: TextStyle(color: Colors.purple[700]),
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              onChanged: (Nivel? lvl) async {
                setState(() {
                  nivel = lvl!;
                });
                //consulta para obtener las materias
                final resp = await http.get(
                  Uri.parse('${ValuesGlobal.urlBase}getCargos?'
                      'nivel_id=${nivel.id}'),
                );
                cargos = cargosFromJson(resp.body);
                cargos.insert(
                    0,
                    Cargo(
                        id: 0,
                        nombre: 'Seleccione el cargo...',
                        createdAt: '',
                        nivelId: 0,
                        updatedAt: ''));
                cargo = cargos[0];
                //isSameArea = true;

                setState(() {});
              },
              items: widget.nivels.map((Nivel map) {
                return DropdownMenuItem<Nivel>(
                    value: map, child: Text(map.nombre));
              }).toList(),
            ),
          ),
        ),
        /*Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '   Cargo',
                style: TextStyle(color: Colors.blue[400]),
              )),
        ),*/
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              labelText: 'Cargo',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            child: DropdownButton<Cargo>(
              isExpanded: true,
              value: cargo,
                icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              //style: TextStyle(color: Colors.purple[700]),
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              onChanged: (Cargo? lvl) async {
                setState(() {
                  cargo = lvl!;
                });
              },
              items: cargos.map((Cargo map) {
                return DropdownMenuItem<Cargo>(
                    value: map, child: Text(map.nombre));
              }).toList(),
            ),
          ),
        ),
        Container(
          height: 50,
          color: const Color.fromARGB(255, 207, 207, 207),
          child: const Center(
            child: Text(
              'Agregue los circuitos:',
              style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 19, 19, 19),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: DropdownButton<Map>(
                  isExpanded: true,
                  value: circuito,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  //style: TextStyle(color: Colors.purple[700]),
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  onChanged: (Map? lvl) async {
                    setState(() {
                      circuito = lvl!;
                    });
                  },
                  items: circuitos.map((Map map) {
                    return DropdownMenuItem<Map>(
                        value: map, child: Text(map["name"]));
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () async {
                  setState(() {
                    circuitosSelected.add(circuito["value"]);
                  });
                },
                child: const Icon(Icons.add_circle_outlined,
                    color: Colors.blue, size: 30),
              ),
            ),
            Expanded(
                flex: 4,
                child: Container(
                  color: Color.fromARGB(255, 242, 242, 242),
                  child: Row(children: [
                    for (int i = 0; i < circuitosSelected.length; i++)
                      Text(
                        "${circuitosSelected[i]} - ",
                        style: const TextStyle(fontSize: 20.0),
                      )
                  ]),
                ))
          ],
        ),
        Container(
          margin: const EdgeInsets.all(25),
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 54, 174, 244),
                elevation: 0,
              ),
              onPressed: () async {
                var res = await http.post(
                    Uri.parse('${ValuesGlobal.urlBase}savePreference'),
                    body: {
                      "nivel_id": nivel.id.toString(),
                      "cargo_id": cargo.id.toString(),
                      "circuitos": json.encode(circuitos),
                    });
                if (res.statusCode == 200) {}
              },
              child: const Text("Guardar"),
            ),
          ),
        ),
      ],
    );
  }
}
