import 'package:flutter/material.dart';

class MsgTile extends StatelessWidget {
  final String role;
  final String content;
  const MsgTile({required this.role, required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_circle),
              Text(role),
            ],
          ),
          Text(
            content,
            softWrap: true,
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}