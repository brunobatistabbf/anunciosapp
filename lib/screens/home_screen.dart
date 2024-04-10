import 'package:anunciosapp/models/todo.dart';
import 'package:anunciosapp/screens/cadastro_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> _lista = [];

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
                      builder: (context) =>
                          CadastroScreen(task: _lista[position])));
              if (editedTask != null) {
                setState(() {
                  _lista[position] = editedTask;
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          try {
            Todo newTask = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => CadastroScreen()));
            setState(() {
              _lista.add(newTask);
            });
          } catch (error) {
            print("Error: ${error.toString()}");
          }
        },
      ),
    );
  }
}
