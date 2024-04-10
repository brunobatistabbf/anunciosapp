import 'dart:js';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:anunciosapp/screens/home_screen.dart';
import 'package:anunciosapp/screens/cadastro_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Anuncios APP',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    initialRoute: "/",
    routes: {
      "/": (context) => HomeScreen(),
      "/cadastro": (context) => CadastroScreen()
    },
  ));
}
