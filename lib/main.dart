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
  final Map<int, String> passwords = {};

  @override
  void initState() {
    super.initState();

    //Inicializar valores por default
    for (var lengh in passwordLengths) {
      passwords[lengh] = 'Contraseñas sin guardar';
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
                children: passwordLengths.map((length) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  passwords[length] = generarPassword(length);
                                });
                              },
                              //Icon Refresh
                              icon: Icon(Icons.refresh),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  Clipboard.setData(
                                      ClipboardData(text: passwords[length]!));
                                });
                              },
                              //Icono Copy
                              icon: Icon(Icons.copy),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
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
