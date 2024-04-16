import 'dart:io';

class Todo {
  int? id;
  late String texto;
  bool done = false;
  File? image;

  Todo(this.texto, this.image);

  Todo.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.texto = map['texto'];
    this.done = map['done'] == 1 ? true : false;
    this.image = map['imagePath'] != '' ? File(map['imagePath']) : null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'texto': this.texto,
      'done': this.done,
      'imagePath': this.image != null ? this.image!.path : ''
    };
    return map;
  }

  @override
  String toString() {
    return "Task(id: $id, texto: $texto, done: $done, image: $image)";
  }
}
