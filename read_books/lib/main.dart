import 'package:flutter/material.dart';
import 'package:read_books/pdf_viewers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Books",
      color: Colors.white,
      theme: ThemeData(

      ),
      home: PdfViewers(),
    );
  }
}
