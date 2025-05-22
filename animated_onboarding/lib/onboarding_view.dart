import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoOnboarding(
        pages: [
          WhatsNewPage(
            title: Text("Airline"),
            features: [
              WhatsNewFeature(
                title: Text("Data"),
                description: Text("Description"),
                icon: Icon(CupertinoIcons.airplane),
              ),
            ],
          ),
          WhatsNewPage(
            title: Text("Cars"),
            features: [
              WhatsNewFeature(
                title: Text("Dat"),
                description: Text("Description"),
                icon: Icon(CupertinoIcons.car_detailed),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
