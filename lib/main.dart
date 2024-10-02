import 'package:flutter/material.dart';
import 'package:oversea_mip/screens/pick_pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
          primaryColor: Colors.indigo,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.indigo)),
      debugShowCheckedModeBanner: false,
      home: const FilePickerDemo(),
    );
  }
}
