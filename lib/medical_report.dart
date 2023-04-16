import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'create_graph.dart';

class MedicalReport extends StatefulWidget {
  const MedicalReport({super.key, required this.title});

  final String title;

  @override
  State<MedicalReport> createState() => _MedicalReportState();
}

class _MedicalReportState extends State<MedicalReport> {
  final String apiUrl =
      'https://cloud.google.api'; // calls the google cloud API service

  Future<Map<dynamic, dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Map jsonData = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<Map<dynamic, dynamic>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  for (String key in snapshot.data!.keys)
                    Column(
                      children: [
                        CreateGraph(
                            value: snapshot.data![key]['value'],
                            range: snapshot.data![key]['range'],
                            effects: snapshot.data![key]['effects'],
                            prevention: snapshot.data![key]['prevention'],
                            name: key),
                        const Divider(thickness: 1),
                      ],
                    ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          // By default, show a loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
