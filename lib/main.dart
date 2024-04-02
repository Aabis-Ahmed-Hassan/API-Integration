import 'package:api_integration/users_get_api_without_modal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UsersGetApiWithoutModal(),
    );
  }
}
