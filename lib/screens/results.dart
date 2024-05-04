// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:clean_helminal/widgets/constants.dart';
import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  bool failedSecondAttempt;
  bool failedThirdAttempt;
  int noOfAttempts;
  final List listOfWords;
  List<bool> firstGuessResults;
  List<bool> secondGuessResults;
  List<bool> thirdGuessResults;

  Results({
    super.key,
    required this.failedSecondAttempt,
    required this.failedThirdAttempt,
    required this.listOfWords,
    required this.noOfAttempts,
    required this.firstGuessResults,
    required this.secondGuessResults,
    required this.thirdGuessResults,
  });

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  void initState() {
    super.initState();
  }

  Widget checkFirstList(bool result) {
    return result == true
        ? const TableCell(child: Icon(Icons.check_box, color: Colors.green))
        : Container();
  }

  Widget checkFirstAndSecondList(bool firstResult, secondResult) {
    return firstResult == true && secondResult == true
        ? const TableCell(child: Icon(Icons.check_box, color: Colors.green))
        : Container();
  }

  Widget checkFirstSecondAndThirdList(
      bool firstResult, secondResult, thirdResult) {
    return firstResult == true && secondResult == true && thirdResult == true
        ? const TableCell(child: Icon(Icons.check_box, color: Colors.green))
        : Container();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Close')),
                ),
                addVerticalSpacing(20),
                // for (int i = 0; i < widget.listOfWords.length; i++)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Text(
                //         widget.listOfWords[i],
                //         style: TextStyle(
                //           color: widget.firstGuessResults[i] == true
                //               ? Colors.green
                //               : Colors.redAccent,
                //         ),
                //       ),
                //       widget.failedSecondAttempt
                //           ? Text(
                //               widget.listOfWords[i],
                //               style: TextStyle(
                //                 color: widget.secondGuessResults[i] == true
                //                     ? Colors.green
                //                     : Colors.redAccent,
                //               ),
                //             )
                //           : Container(),
                //       widget.failedThirdAttempt
                //           ? Text(
                //               widget.listOfWords[i],
                //               style: TextStyle(
                //                 color: widget.thirdGuessResults[i] == true
                //                     ? Colors.green
                //                     : Colors.redAccent,
                //               ),
                //             )
                //           : Container(),

                //     ],
                //   ),
                    // add table view as well using the table widget
                    Table(
                      border: TableBorder.all(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: const [
                        TableRow(
                          children: [
                            TableCell(
                              child: Text(
                                '1st Attempt',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                '2nd Attempt',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                '3rd Attempt',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Result',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    for (int i = 0; i < widget.listOfWords.length; i++)

                      Table(
                        border: TableBorder.all(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Text(
                                widget.listOfWords[i],
                                style: TextStyle(
                                  color: widget.firstGuessResults[i] == true
                                     ? Colors.green
                                      : Colors.redAccent,
                                ),
                              ),
                            ),
                        widget.failedSecondAttempt? TableCell(
                              child: Text(
                                widget.listOfWords[i],
                                style: TextStyle(
                                  color: widget.secondGuessResults[i] == true
                                     ? Colors.green
                                      : Colors.redAccent,
                                ),
                              ),
                            ): Container(),
                           widget.failedThirdAttempt ?TableCell(
                              child: Text(
                                 widget.listOfWords[i],
                                style: TextStyle(
                                  color: widget.thirdGuessResults[i] == true
                                     ? Colors.green
                                      : Colors.redAccent,
                                ),
                              ),
                            ): Container(),
                            if(!widget.failedSecondAttempt && !widget.failedThirdAttempt)  checkFirstList(widget.firstGuessResults[i]),
                            if (widget.failedSecondAttempt && !widget.failedThirdAttempt)
                              checkFirstAndSecondList(widget.firstGuessResults[i],
                                  widget.secondGuessResults[i]),
                            if (widget.failedThirdAttempt && widget.failedSecondAttempt)
                              checkFirstSecondAndThirdList(
                                  widget.firstGuessResults[i],
                                  widget.secondGuessResults[i],
                                  widget.thirdGuessResults[i]),
                          ],
                        ),
                      ]
                    ),


              ]),
            ),
          ),
        ),
      ),
    );
  }
}
