
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: onClicked,
    child: Text(
      text,
      style: const TextStyle(fontSize: 24),
    ),
  );
}