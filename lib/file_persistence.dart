import 'dart:convert';
import 'dart:io';

import 'package:anunciosapp/models/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FilePesistence {
  Future<File> _getLocalFile() async {
    final directory = await getApplicationCacheDirectory();
    String localPath = directory.path;
    File localfile = File('$localPath/taskfile.json');
    if (localfile.existsSync()) {
      return localfile;
    } else {
      return localfile.create(recursive: true);
    }
  }

  Future saveData(List<Todo> tasks) async {
    final localFile = await _getLocalFile();
    List taskList = [];
    tasks.forEach((tarefa) {
      taskList.add(tarefa.toMap());
    });
    String data = json.encode(taskList);
    return localFile.writeAsStringSync(data);
  }
}
