import 'package:flutter/material.dart';

class MsgTile extends StatelessWidget {
  final String author;
  final String content;
  const MsgTile({required this.author, required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_circle),
              Text(author),
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