// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  bool failedSecondAttempt;
  bool failedThirdAttempt;
  int noOfMatchesFirstChoice;
  int noOfMatchesSecondChoice;
  int noOfMatchesThirdChoice;

  final List listOfWords;
  final List<int> listOfNoOfMatchesFirstGuess;
  final List<int> listOfNoOfMatchesSecondGuess;
  final List<int> listOfNoOfMatchesThirdGuess;

  Results({
    super.key,
    required this.failedSecondAttempt,
    required this.failedThirdAttempt,
    required this.listOfWords,
    required this.listOfNoOfMatchesFirstGuess,
    required this.listOfNoOfMatchesSecondGuess,
    required this.listOfNoOfMatchesThirdGuess,
    required this.noOfMatchesFirstChoice,
    required this.noOfMatchesSecondChoice,
    required this.noOfMatchesThirdChoice,
  });

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  List<bool> firstGuessResults = [];
  List<bool> secondGuessResults = [];
  List<bool> thirdGuessResults = [];

  @override
  void initState() {
    firstGuessResults = compareIntToList(
        widget.noOfMatchesFirstChoice, widget.listOfNoOfMatchesFirstGuess);
    if (widget.failedSecondAttempt == true)
      secondGuessResults = compareIntToList(
          widget.noOfMatchesSecondChoice, widget.listOfNoOfMatchesSecondGuess);
    if (widget.failedThirdAttempt == true)
      thirdGuessResults = compareIntToList(
          widget.noOfMatchesThirdChoice, widget.listOfNoOfMatchesThirdGuess);
    super.initState();
  }

  List<bool> compareIntToList(int singleInteger, List<int> integerList) {
    List<bool> results = [];

    // Iterate through each integer in the list
    for (int number in integerList) {
      // Compare the single integer to the current integer in the list
      if (singleInteger == number) {
        // If they are the same, add true to the results list
        results.add(true);
      } else {
        // Otherwise, add false to the results list
        results.add(false);
      }
    }
    // Return the list of results
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     const Text('Results',
              //         style:
              //             TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              //     Table(
              //         border: TableBorder.all(),
              //         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              //         children: [
              //           const TableRow(children: [
              //             TableCell(child: Text('First attempt')),
              //             TableCell(child: Text('Second attempt')),
              //             TableCell(child: Text('Third attempt')),
              //             TableCell(child: Text('Verdict')),
              //           ]),
              //           for(int i=0; i<widget.listOfWords.length; i++)
              //             TableRow(
              //               children: [
              //                 TableCell(child: Text(widget.listOfWords[i])),
              //                 widget.failedSecondAttempt ? TableCell(child: Container()):TableCell(child: Container()),
              //                 widget.failedThirdAttempt ? TableCell(child: Container()):TableCell(child: Container()),
              //                 TableCell(child: Text(widget.listOfWords[i])),
              //
              //               ],
              //             )
              //
              //         ]),
              //     ElevatedButton(
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //       child: const Text('Close'),
              //     ),
              //   ],
              // ),
              child: Column(children: [
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Close')),
                ),
                for (int i = 0; i < widget.listOfWords.length; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.listOfWords[i],
                        style: TextStyle(
                          color: firstGuessResults[i] == true
                              ? Colors.green
                              : Colors.redAccent,
                        ),
                      ),
                      widget.failedSecondAttempt
                          ? Text(
                              widget.listOfWords[i],
                              style: TextStyle(
                                color: secondGuessResults[i] == true
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                            )
                          : Container(),
                      widget.failedThirdAttempt
                          ? Text(
                              widget.listOfWords[i],
                              style: TextStyle(
                                color: thirdGuessResults[i] == true
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                            )
                          : Container(),
                    ],
                  ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
