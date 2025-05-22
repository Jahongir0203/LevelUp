import 'package:flutter/material.dart';
import 'package:stripe_service/services/stripe_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            StripeService.instance.makePayment();
          },
          child: Text("Pay"),
        ),
      ),
    );
  }
}
