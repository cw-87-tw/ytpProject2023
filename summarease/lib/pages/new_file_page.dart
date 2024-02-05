import 'package:flutter/material.dart';
import '../util/op_tile.dart';

class NewFilePage extends StatelessWidget {
  const NewFilePage({super.key});

  Future<void> uploadFileToFirebase(String filePath) async {
    // Replace "your_collection" and "your_field" with your Firebase collection and field names
    CollectionReference collection = FirebaseFirestore.instance.collection('your_collection');

    // Read the content of the video file as bytes
    List<int> fileBytes = await File(filePath).readAsBytes();

    // Upload the content to Firebase
    await collection.add({
      'your_video_field': fileBytes,
    });

    // Show a message or perform any other action after successful upload
    print('Video uploaded to Firebase successfully!');
  }

  void uploadVideo() {
    String filePath = '';

    Future<void> pickAndUploadFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null) {
        filePath = result.files.single.path!;
        uploadFileToFirebase(filePath);
      }
    }    
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
