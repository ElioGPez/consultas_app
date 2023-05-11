import 'dart:convert';
import 'dart:io';

import 'package:consulta_app/models/vacantes.dart';
import 'package:consulta_app/screens/login_screen.dart';
import 'package:consulta_app/screens/new_preferences.dart';
import 'package:consulta_app/utils/next_screen.dart';
import 'package:consulta_app/provider/sign_in_provider.dart';
import 'package:consulta_app/utils/widgets/item_list_vacante.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:http/http.dart' as http;

import '../utils/config.dart';
import '../utils/values_host.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // change read to watch!!!!
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultas SIME'),
        actions: [
          IconButton(
              onPressed: () {
                sp.userSignOut();
                nextScreenReplace(context, const LoginScreen());
              },
              icon: const Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(Config.app_icon),
              height: 90,
              //width: 80,
              //fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            /*Text(
              "Welcome ${sp.name} - con ID ${sp.id}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${sp.email}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    /*var result = await MercadoPagoMobileCheckout.startCheckout(
                        'TEST-6e80697d-a015-4c44-a810-c7633c68ceb7',
                        '128012470-6d121e7a-28d4-433c-9052-4884b1812d06');
                    result;*/
                    nextScreenReplace(context, const NewPreefrences());
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_circle_outlined,
                          color: Colors.blue, size: 60),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: const Text(
                          "CREAR PREFERENCIA",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.description, color: Colors.blue, size: 60),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: const Text(
                        "LISTADO",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
                      Container(
            height: 40,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'VACANTES',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
            FutureBuilder(
              future: getVacantes(),
              builder: (context, snapshot) {
                List<Widget> children;
                final List<int> colorCodes = <int>[600, 500, 100];

                if (snapshot.hasData) {
                  List<Consulta>? datos = snapshot.data;

                  children = <Widget>[
                    /*const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 60,
                    ),*/
                    Column(
                      children: [

                        SizedBox(
                  height: MediaQuery.of(context).size.height * 0.56,

                            child: SingleChildScrollView(
                                child: Column(children: [
                          for (var dato in datos!) 
                          ItemListVacante(
                            cargo: dato.padrones![0].cargo!, 
                            descripcion: dato.vacanteDetalle!.descripcion!,
                            fechaInicio: dato.vacante!.fechaPublicacionInicio!,
                            fechaFin: dato.vacante!.fechaPublicacionFin!
                          )
                        ]))
                            ),
                      ],
                    ),

                    /*Column(
                      children: [
                        ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: datos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              color: Colors.amber[colorCodes[index]],
                              child: Center(child: Text('Entry ${datos[0]}')),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        )
                      ],
                    ),*/

                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(height: 20,),
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Consultando vacantes...'),
                    ),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            )
            /*ElevatedButton(
                onPressed: () {
                  sp.userSignOut();
                  nextScreenReplace(context, const LoginScreen());
                },
                child: const Text("SIGNOUT",
                    style: TextStyle(
                      color: Colors.white,
                    )))*/
          ],
        ),
      ),
    );
  }

  Future<List<Consulta>> getVacantes() async {
    try {
      final resp = await http
          .get(Uri.parse('${ValuesGlobal.urlBase}getVacantes'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      resp.body;
      return consultaFromJson(resp.body);
    } on SocketException {
      //Mjs de error para problemas de conexión
      throw Exception('Error de conexion');
    } catch (e) {
      throw Exception(e);
    }
  }
}
