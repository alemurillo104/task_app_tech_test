import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String text;

  const EmptyWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
