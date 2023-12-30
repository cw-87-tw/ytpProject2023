import 'package:flutter/material.dart';

class AccountInfoTile extends StatelessWidget {
  final String username;
  final String something;
  const AccountInfoTile({
    super.key,
    required this.username,
    required this.something,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "使用者名稱: ",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            ),
            Text(
              "看還要放什麼: ",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )
          ],
        ),
        SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              //可能要限制名字長度，不然會overflow(螢幕放不下)
              username,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Text(
              //可能要限制名字長度，不然會overflow(螢幕放不下)
              something,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        )
      ],
    );
  }
}
