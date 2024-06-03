// ignore_for_file: deprecated_member_use

import 'package:clean_helminal/logic/words_analysis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class AnalysisResult extends StatefulWidget {
//   List<List<String>> results;
//
//   AnalysisResult(this.results, {super.key});
//
//   @override
//   State<AnalysisResult> createState() => _AnalysisResultState();
// }
//
// class _AnalysisResultState extends State<AnalysisResult> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     countStringOccurrences(widget.results);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
//         body: Column(children: [
//           const SizedBox(height: 20),
//           const Text(
//             'Analysis Results',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context, true);
//               },
//               child: const Text('Close')),
//           // display the results of countStringOccurrences function
//
//
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.results.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Group ${index + 1}',
//                           style: const TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         Column(
//                           children:
//                               widget.results[index].map((word) => Text(word)).toList(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }


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