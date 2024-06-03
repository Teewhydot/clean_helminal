// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:clean_helminal/logic/words_analysis.dart';
import 'package:flutter/material.dart';

class AnalysisResult extends StatefulWidget {
  List<List<String>> results;

  AnalysisResult(this.results, {super.key});

  @override
  State<AnalysisResult> createState() => _AnalysisResultState();
}

class _AnalysisResultState extends State<AnalysisResult> {
  Map<String, int> stringOccurrences = {};

  @override
  void initState() {
    super.initState();
    stringOccurrences = countStringOccurrences(widget.results);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
          ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Close')),
              Expanded(
                child: ListView.builder(
                  itemCount: stringOccurrences.length,
                  itemBuilder: (context, index) {
                    String key = stringOccurrences.keys.elementAt(index);
                    return ListTile(
                      title: Text('$key: ${stringOccurrences[key]}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}