import 'dart:io';

class Todo {
  late String texto;
  bool done = false;
  File image;

  Todo(this.texto, this.image);
}
