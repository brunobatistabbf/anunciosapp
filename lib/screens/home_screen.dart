import 'dart:io';

import 'package:flutter/material.dart';
import 'package:anunciosapp/models/todo.dart';
import 'package:anunciosapp/database.dart';
import 'package:anunciosapp/screens/cadastro_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> _lista = [];

  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  void _getTasks() async {
    List<Todo>? tasks = await _databaseHelper.getAll();
    if (tasks != null) {
      setState(() {
        _lista = tasks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Anuncios APP",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _lista.length,
        itemBuilder: (context, position) {
          return ListTile(
            leading: _lista[position].image != null
                ? CircleAvatar(
                    child: ClipOval(
                      child: Image.file(_lista[position].image!),
                    ),
                  )
                : const SizedBox(),
            title: Text(_lista[position].texto),
            onTap: () {
              setState(() {
                _lista[position].done = !_lista[position].done;
              });
            },
            onLongPress: () async {
              Todo editedTask = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastroScreen(task: _lista[position]),
                ),
              );
              if (editedTask != null) {
                await _databaseHelper.editTask(editedTask);
                _getTasks();
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          Todo newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroScreen()),
          );

          if (newTask != null) {
            await _databaseHelper.saveTask(newTask);
            _getTasks();
          }
        },
      ),
    );
  }
}
