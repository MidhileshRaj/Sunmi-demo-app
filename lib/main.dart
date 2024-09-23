import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmi_app_demo/controller/configuration_page_controller.dart';
import 'package:sunmi_app_demo/controller/main_controller.dart';
import 'package:sunmi_app_demo/screens/configuration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConfigurationPageController(),
        ),ChangeNotifierProvider(
          create: (context) => MainController(),
        ),
      ],
      child: const MaterialApp(
        home: ConfigurationScreen(),
      ),
    );
  }
}
