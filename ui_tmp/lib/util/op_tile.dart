import 'package:flutter/material.dart';

class OpTile extends StatelessWidget {
  final String opName;
  const OpTile({
    super.key,
    required this.opName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(23.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          )
        ),
        child: Center(
          child: Text(
            opName,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
