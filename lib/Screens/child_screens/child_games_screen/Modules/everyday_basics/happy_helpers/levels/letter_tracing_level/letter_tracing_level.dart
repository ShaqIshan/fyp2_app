import 'package:flutter/material.dart';

class LetterTracingLevel extends StatefulWidget {
  final VoidCallback? onSuccess;

  const LetterTracingLevel({
    super.key,
    this.onSuccess,
  });

  @override
  State<LetterTracingLevel> createState() => LetterTracingLevelState();
}

class LetterTracingLevelState extends State<LetterTracingLevel> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
