import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  final Map<String, dynamic> data;
  final Function(Map<String, dynamic>)? showSummary;

  void onTap() {
    showSummary!(data);
  }

  const FileTile({
    super.key,
    required this.data,
    required this.showSummary,
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
              const Icon(Icons.video_file, size: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['name'],
                    style: Theme.of(context).textTheme.bodyLarge,
                    //textoverflow does not work (might be cuz i lack "expanded"?)
                    // softWrap: false,
                    // maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    data['duration'],
                    style: Theme.of(context).textTheme.bodySmall,
                    // softWrap: false,
                    // maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: const Icon(Icons.remove_red_eye),
              ),
              Icon(Icons.download),
            ],
          ),
        ),
      ),
    );
  }
}
