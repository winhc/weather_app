import 'package:flutter/material.dart';

class EmptyItem extends StatelessWidget {
  const EmptyItem({super.key, required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(icon), Text(message)],
    );
  }
}
