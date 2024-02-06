
import 'package:flutter/material.dart';


import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(app());
}

class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(primaryColor: Colors.blue),
      home: home(),
    );
  }
}

