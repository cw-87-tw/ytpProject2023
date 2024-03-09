import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  
  final data;
  Function()? onTapConversation;

  FileTile({required this.data, required this.onTapConversation, super.key});

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
              const Icon(Icons.video_file, size: 30,),
              Text(
                data['name'],
                style: Theme.of(context).textTheme.bodyLarge,
                //textoverflow does not work (might be cuz i lack "expanded"?)
                // softWrap: false,
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
              ),
              GestureDetector(
                onTap: onTapConversation,
                child: const Icon(Icons.chat),
              ),
              Icon(Icons.download),
            ],
          ),
        ),
      ),
    );
  }
}