import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final String summary;
  final String script;
  final Function(String summary, String script)? toggleSummary;
  const SummaryPage({
    super.key,
    required this.summary,
    required this.script,
    required this.toggleSummary,
  });

  void hideSummary() {
    toggleSummary!("", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: hideSummary, 
                child: Icon(Icons.close_outlined),
              )
            ],
          ),
          Text(summary),
          Text(script),
        ],
      ),
    );
  }
}