import 'package:animated_onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Onboarding',
      debugShowCheckedModeBanner: false,
      home: OnBoardingView(),
    );
  }
}
