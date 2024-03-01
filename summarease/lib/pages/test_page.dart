import 'dart:io';
import '../util/op_tile.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../process/videoToText.dart';
import '../process/textSummary.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String displayText = "Haven't transcripted yet";
  Future<void> uploadVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'avi', 'mkv', 'flv', 'mov'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      print("\n\n\nReceived user file\n\n\n");
      // call the whisper API here
      setState(() {
        displayText = "processing...";
      });
      var transcription = await convertSpeechToText(file.path);
      setState(() {
        displayText = transcription;
      });
      var summary = await summarizeText(transcription);
      setState(() {
        displayText = summary;
      });
    } else {
      print("No file selected");
    }
  }
  Future<void> test() async {
    var summary = await summarizeText("我們應該差不多都可以先來開始 那我們上次講迴圈嘛 但其實幾乎都還沒有講完 所以我們現在就把它講一講吧 好 謝謝上一次我們複習 while 迴圈嘛 就是當里面的條件成立的時候 當這個括號里面的條件成立的時候 執行里面做的事情這 樣 那我們現在來講 後迴圈吧 do while 真的用不到 所以我就不講 那 這是最基本的嘛 因為我相信大家都還記得 對我就講快快一點點 就是 會迴圈這樣寫 然後 他有三個區塊 第一個區塊是 第一次進去的時候會執行 第二個區塊是 每一次要進去執行里面的條件之前 會做的事情 會 做檢查 然後最後一個是 每一輪結束以後會做這個 每一輪結束以後再做 這樣講起來十分抽象 所以我們就可以直接來寫寫看 像是 我們就寫hole 我們第一次做的時候 宣告一個變數叫做i 然後他的數值是1 然後呢 假設我們想要 印出 什麼1到20的偶數好了");
      setState(() {
        displayText = summary;
      });
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
                OpTile(
                  opName: '測試區',
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: test,
                ),
                Text(displayText)
              ],
            ),
          ),
        ));
  }
}
