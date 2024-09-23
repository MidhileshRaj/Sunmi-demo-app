import 'package:flutter/material.dart';

class CustomTextFieldDesign extends StatelessWidget {
  const CustomTextFieldDesign(
      {super.key,
      required this.label,
      this.hint = "",
      required this.controller,
      this.obscure = false,
      this.enable= true});

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * .5,
            child: TextField(
              enabled: enable,
              obscureText: obscure,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                labelText: label,
                hintText: hint,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 5),
                ),
              ),
              controller: controller,
            ),
          )
        ],
      ),
    );
  }
}
