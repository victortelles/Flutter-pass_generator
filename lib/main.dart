//Proyecto: Generacion de contraseñas-Diferentes tamaños de caracteres.
//Libreria de random
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 117, 135, 237),
        ),
      ),
      //Contenido
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Lista de longitud de caracteres
  final List<int> passwordLengths = [8, 12, 16, 20, 24, 28, 32, 36, 40];

  //Mapa para almacenar las contraseñas generadas
  //Guardar la longitud de caracter y el string del password.
  final Map<int, String> passwords = {};

  @override
  void initState() {
    super.initState();

    //Inicializar valores por default
    for (var length in passwordLengths) {
      passwords[length] = 'Contraseñas sin guardar';
    }
  }

  //Esqueleto
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de contraseñas'),
      ),
      //Contenido
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              //Widget ListView
              child: ListView(
                //Lista de longitud de caracteres
                children: passwordLengths.map((length) {
                  //Contenedor principal
                  return Container(
                    //Caja
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //Espaciado
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        //Text Caracteres
                        Text(
                          "$length caracteres",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        //Text passwords
                        Text(passwords[length]!),

                        //Fila para Iconos
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Icon Button Refresh
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  passwords[length] = generarPassword(length);
                                });
                              },
                              icon: Icon(Icons.refresh),
                            ),
                            //Icon Button Copy
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  Clipboard.setData(
                                      ClipboardData(text: passwords[length]!));
                                });
                              },
                              icon: Icon(Icons.copy),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            //Botones
            ElevatedButton(
              onPressed: () {
                setState(() {
                  for (var length in passwordLengths) {
                    passwords[length] = generarPassword(length);
                  }
                });

                //Alertas
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("Se generaron contraseñas"),
                    ),
                  );
              },
              //Text
              child: Text("Generar Contraseñas"),
            ),

            OutlinedButton(
              onPressed: () {
                setState(() {
                  for (var length in passwordLengths) {
                    passwords[length] = "Contraseña sin generar";
                  }
                });
              },
              //Text
              child: Text("Borrar contraseñas"),
            ),
          ],
        ),
      ),
    );
  }

  //Funcion para generar la contraseña
  String generarPassword(int charsNum) {
    return String.fromCharCodes(
      List.generate(charsNum, (index) => Random().nextInt(48) + 60),
    );
  }
}
