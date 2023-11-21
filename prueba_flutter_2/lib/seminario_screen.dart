import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Vamos a hacer una pagina de noticias

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsItem> newsList = [];

  @override
  void initState() {
    super.initState();
    _loadNewsData();
  }

  static const String apiUrl = 'http://localhost:9090/news';
  Future<void> _loadNewsData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        // Mapea la respuesta a objetos NewsItem
        newsList = responseData.map((data) => NewsItem.fromJson(data)).toList();

        // Notifica al framework que el estado ha cambiado
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error en la solicitud de notícies'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error al conectar amb el servidor'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notícies'),
        backgroundColor: Color(0xFF486D28),
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(newsList[index].imageUrl,
                    height: 200, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    newsList[index].title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NewsItem {
  final String title;
  final String imageUrl;
  final String content;

  NewsItem(
      {required this.title, required this.imageUrl, required this.content});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'],
      imageUrl: json['imageUrl'],
      content: json['content'],
    );
  }
}
