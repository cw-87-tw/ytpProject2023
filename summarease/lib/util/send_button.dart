import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final Function()? onTap;
  const SendButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Icon(Icons.send, color: Colors.white,)
      ),
    );
  }
}