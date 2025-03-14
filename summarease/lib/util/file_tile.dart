import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  
  final DocumentSnapshot data;
  final Function()? onTapConversation;

  const FileTile({required this.data, required this.onTapConversation, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    data['name']?? 'no name',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTapConversation,
                child: const Icon(Icons.chat),
              ),
            ],
          ),
        ),
      ),
    );
  }
}