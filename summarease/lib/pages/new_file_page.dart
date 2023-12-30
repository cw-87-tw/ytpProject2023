import 'package:flutter/material.dart';
import '../util/op_tile.dart';

class NewFilePage extends StatelessWidget {
  const NewFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          toolbarHeight: 80,
          leading: const Icon(Icons.add, color: Colors.white, size: 35),
          title: Text(
            '新增檔案',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OpTile(opName: '錄製影片'),
                OpTile(opName: '上傳影片'),
                OpTile(opName: '錄製音檔'),
                OpTile(opName: '上傳音檔'),

                OpTile(opName: '預設寄信對象',)
              ],
            ),
          ),
        )
    );
  }
}
