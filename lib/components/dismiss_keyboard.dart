import 'package:flutter/material.dart';

class KeyboardService {
  static final KeyboardService instance = KeyboardService._internal();
  KeyboardService._internal();

  dismiss() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

class DismissKeyboard extends StatelessWidget {
  final Widget? child;

  const DismissKeyboard({super.key, required this.child});

  void _dismissKeyboard() {
    KeyboardService.instance.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _dismissKeyboard(),
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
