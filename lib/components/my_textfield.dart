import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String? hintext;
  final TextEditingController? controller;
  const MyTextfield({super.key, required this.hintext,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintext,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        controller: controller,
      ),
    );
  }
}
