import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_service/constants.dart';
import 'package:stripe_service/home_page.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
 Stripe.publishableKey=stripePublishKey;


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stripe service',
      home: HomePage(),
    );
  }
}
