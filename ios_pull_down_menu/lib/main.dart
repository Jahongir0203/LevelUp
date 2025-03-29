import 'package:flutter/material.dart';
import 'package:ios_pull_down_menu/home_page.dart';

void main() {
  runApp(const IosPullDown());
}

class IosPullDown extends StatelessWidget {
  const IosPullDown({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      color: Colors.black,
      title: "Ios pull down",
      home: HomePage(),
    );
  }
}
