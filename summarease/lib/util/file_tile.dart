import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  final String fileName;
  final String fileTime;
  const FileTile({
    super.key,
    required this.fileName,
    required this.fileTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.video_file, size: 30,),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        fileTime,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ],
              ),
              Icon(Icons.download),
            ],
          ),
        ),
      ),
    );
  }
}
