import 'dart:io';

import 'package:anunciosapp/models/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadastroScreen extends StatefulWidget {
  final Todo? task; // Adicione esta linha para receber a tarefa

  // Adicione este construtor para receber a tarefa
  CadastroScreen({Key? key, this.task}) : super(key: key);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  File? _image;

  @override
  void initState() {
    super.initState();
    // Preencha o campo de texto com a descrição da tarefa, se existir
    if (widget.task != null) {
      setState(() {
        _textController.text = widget.task!.texto;
        _image = widget.task!.image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Cadastro Anuncio",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(width: 1, color: Colors.grey),
                  shape: BoxShape.circle,
                ),
                child: _image == null
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 30,
                      )
                    : ClipOval(
                        child: Image.file(_image!),
                      )),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? pickedFile =
                  await _picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                setState(() {
                  _image = File(pickedFile.path);
                });
              }
            },
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: TextFormField(
                    controller: _textController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Insira o anuncio",
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Preenchimento Obrigatorio";
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: ElevatedButton(
                          child: const Text(
                            "Cadastrar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formkey.currentState!.validate()) {
                              Todo newTask = Todo(
                                  _textController.text, _image ?? File(''));
                              Navigator.pop(context, newTask);
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: ElevatedButton(
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 85, 0),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
