import 'package:flutter/material.dart';

class ItemListVacante extends StatelessWidget {
  final String cargo;
  final String descripcion;
  final String fechaInicio;
  final String fechaFin;

  const ItemListVacante(
      {Key? key,
      required this.cargo,
      required this.descripcion,
      required this.fechaInicio,
      required this.fechaFin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(3, 7, 3, 7),
        child: Container(
          padding: const EdgeInsets.only(bottom: 0,top: 10),
          decoration: const BoxDecoration(
              border: Border(
                 // bottom: BorderSide(
                 //     color: Color.fromARGB(255, 195, 218, 246), width: 4),
                  top: BorderSide(
                      color: Color.fromARGB(255, 195, 218, 246), width: 4))),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: const TextStyle(fontSize: 14.0),
                    children: [
                      TextSpan(
                          text: cargo,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 10, 96, 166))),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: const TextStyle(
                        fontSize: 13.0, color: Color.fromARGB(255, 58, 58, 58)),
                    children: [
                      const TextSpan(
                          text: 'Descripción: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: descripcion,
                          style: const TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: const TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 13.0, color: Color.fromARGB(255, 0, 137, 155)),
                    children: [
                      const TextSpan(
                          text: 'Inicio: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: fechaInicio,
                          style: const TextStyle(color: Color.fromARGB(255, 0, 137, 155))),
                      const TextSpan(
                          text: ' - Fin: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: fechaFin,
                          style: const TextStyle(color: Color.fromARGB(255, 0, 137, 155))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
