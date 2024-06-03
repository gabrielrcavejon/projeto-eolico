import 'package:flutter/material.dart';

import 'widgets/grafico.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Eólico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: const Text("Projeto Eólico"),
        ),
        body: const GraficoVolts(title: 'Projeto Eólico'),
      ),
    );
  }
}
