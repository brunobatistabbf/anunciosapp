import 'dart:io';

class Todo {
  late String texto;
  bool done = false;
  File? image;

  Todo(this.texto, this.image);

  Todo.fromMap(Map<String, dynamic> map) {
    this.texto = map['texto'];
    this.done = map['done'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'texto': this.texto,
      'done': this.done,
    };
    return map;
  }
}
