import 'package:flutter/material.dart';
import 'package:local_notifications/home_page.dart';
import 'package:local_notifications/service/notifications_service.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  NotificationsService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
