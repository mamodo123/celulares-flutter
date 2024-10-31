import 'dart:async';

import 'package:flutter/material.dart';

class MyAppButton extends StatelessWidget {
  final String text;
  final FutureOr<void> Function() onPressed;

  const MyAppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
