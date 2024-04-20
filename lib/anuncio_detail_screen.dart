import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:anunciosapp/models/todo.dart';

class AnuncioDetailScreen extends StatelessWidget {
  final Todo anuncio;

  AnuncioDetailScreen({required this.anuncio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Anúncio'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: anuncio.image != null
                  ? FileImage(anuncio.image!)
                  : AssetImage('assets/default_image.jpg') as ImageProvider,
            ),
            title: Text(anuncio.texto),
            subtitle: Text(anuncio.done ? 'Concluído' : 'Pendente'),
          ),
          ElevatedButton(
            onPressed: () {
              _launchSMS(anuncio.texto);
            },
            child: Text('Compartilhar via SMS'),
          ),
        ],
      ),
    );
  }

  void _launchSMS(String texto) async {
    final Uri uri = Uri(
      scheme: 'sms',
      path: '', // Número de telefone para o qual enviar o SMS
      queryParameters: {
        'body': texto,
      },
    );
    final String url = uri.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
