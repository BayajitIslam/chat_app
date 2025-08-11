import 'package:flutter/material.dart';

class ChatPages extends StatelessWidget {
  final String reciverMail;
  const ChatPages({super.key,required this.reciverMail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(reciverMail),
      ),
    );
  }
}
