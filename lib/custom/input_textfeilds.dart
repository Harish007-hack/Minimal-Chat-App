import 'package:flutter/material.dart';

class InputTextfeilds extends StatelessWidget {
  const InputTextfeilds({
    super.key,
    required this.hintText,
    required this.textController,
    required this.obscureText,
  });
  final String hintText;
  final TextEditingController textController;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Theme.of(context).colorScheme.tertiary,
      showCursor: true,
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              // style: BorderStyle.none
            ),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(10)),
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary,)
      ),
      obscureText: obscureText,
    );
  }
}
