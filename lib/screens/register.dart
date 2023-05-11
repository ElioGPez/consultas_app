import 'package:consulta_app/screens/login_screen.dart';
import 'package:consulta_app/screens/new_preferences.dart';
import 'package:consulta_app/utils/next_screen.dart';
import 'package:consulta_app/provider/sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('Realizar el pago'),
            const SizedBox(height: 20,),
            const Text("El servicio tiene un costo de solo 100 mesuales. Presione en el siguiente boton para continuar"),
            const SizedBox(
              height: 20,
            ),
            /*Text(
              "Welcome ${sp.name} - con ID ${sp.id}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),*/
            const SizedBox(
              height: 10,
            ),
            /*Text(
              "${sp.email}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),*/
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    var result = await MercadoPagoMobileCheckout.startCheckout(
                        'TEST-6e80697d-a015-4c44-a810-c7633c68ceb7',
                        '128012470-6d121e7a-28d4-433c-9052-4884b1812d06');
                    result;
                    //nextScreenReplace(context, const NewPreefrences());
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_circle_outlined,
                          color: Colors.blue, size: 70),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: const Text(
                          "New Preferencias",
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
                ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("PROVIDER:"),
                const SizedBox(
                  width: 5,
                ),
                Text("${sp.provider}".toUpperCase(),
                    style: const TextStyle(color: Colors.red)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  sp.userSignOut();
                  nextScreenReplace(context, const LoginScreen());
                },
                child: const Text("SIGNOUT",
                    style: TextStyle(
                      color: Colors.white,
                    )))
          ],
        ),
      ),
    );
  }
}
