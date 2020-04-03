import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'Monitoring.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      title: "Sada-e-Niswaan",
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
     home: MonitoringPage(auth: Auth(),),
  
    
    

    );
  }
}