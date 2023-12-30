import 'package:flutter/material.dart';
import '../util/file_tile.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 80,
        leading: const Icon(Icons.list_alt, color: Colors.white, size: 35),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '檔案紀錄',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 40.0),
          children: const [
            FileTile(
              fileName: 'file1',
              fileTime: '2023-12-30 00:00'
            ),
            FileTile(
              fileName: 'file2',
              fileTime: '2023-12-30 11:11'
            ),
          ],
        ),
      ),
    );
  }
}
