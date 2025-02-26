import 'package:flutter/material.dart';
import 'package:local_notifications/service/notifications_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print('AAA');
            NotificationsService().showNotifications('Yes,It works!');
          },
          child: Text('Local Notification'),
        ),
      ),
    );
  }
}
