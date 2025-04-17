import 'package:flutter/material.dart';
import 'package:flutter_nfc/presentation/pages/nfc_manager_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "NFC",
      color: Colors.white,
      home: HomePage(),
    );
  }
}
