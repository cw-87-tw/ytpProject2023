import 'package:flutter/material.dart';

class MsgTile extends StatelessWidget {
  final String role;
  final String content;
  const MsgTile({required this.role, required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12.0)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.account_circle),
                ),
                Text(
                  role,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 8.0, bottom: 10.0),
                  child: Text(
                    content,
                    softWrap: true,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}