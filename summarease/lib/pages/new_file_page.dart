import 'package:flutter/material.dart';
import '../util/op_tile.dart';

class NewFilePage extends StatelessWidget {
  const NewFilePage({super.key});

  void uploadVideo() {
    //
  }

  void uploadAudio() {
    //
  }

  void setEmailRecipient() {
    //
  }

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
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OpTile(
                  opName: '上傳影片',
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: uploadVideo,
                ),
                SizedBox(height: 30),
                OpTile(
                  opName: '上傳音檔',
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: uploadAudio,
                ),
                SizedBox(height: 30),
                OpTile(
                  opName: '預設寄信對象',
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: setEmailRecipient,
                )
              ],
            ),
          ),
        )
    );
  }
}
