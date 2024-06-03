import 'package:clean_helminal/logic/words_analysis.dart';
import 'package:clean_helminal/screens/analysis_results.dart';
import 'package:clean_helminal/screens/results.dart';
import 'package:clean_helminal/widgets/constants.dart';
import 'package:clean_helminal/widgets/custom_textfield.dart';
import 'package:clean_helminal/widgets/reusable_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController wordLengthController = TextEditingController();
  final TextEditingController firstChoiceController = TextEditingController();
  final TextEditingController secondChoiceController = TextEditingController();
  final TextEditingController thirdChoiceController = TextEditingController();
  final TextEditingController noOfMatchesControllerFirstChoice =
      TextEditingController();
  final TextEditingController noOfMatchesControllerSecondChoice =
      TextEditingController();
  final TextEditingController noOfMatchesControllerThirdChoice =
      TextEditingController();

  final GlobalKey firstChoiceKey = GlobalKey();
  final GlobalKey secondChoiceKey = GlobalKey();
  final GlobalKey thirdChoiceKey = GlobalKey();

  int wordLength = 2;
  int noOfMatchesFirstChoice = 0;
  int noOfMatchesSecondChoice = 0;
  int noOfMatchesThirdChoice = 0;
  List<TextEditingController> controllers = [];
  List<GlobalKey> fieldKeys = [];
  List<int> listOfNoOfMatchesFirstGuess = [];
  List<int> listOfNoOfMatchesSecondGuess = [];
  List<int> listOfNoOfMatchesThirdGuess = [];
  List<String> listOfWords = [];
  List<bool> firstGuessResults = [];
  List<bool> secondGuessResults = [];
  List<bool> thirdGuessResults = [];

  bool failedSecondAttempt = false;
  bool failedThirdAttempt = false;
  int noOfAttempts = 1;
  void upDateNoOfAttempts() {
    if (failedSecondAttempt && !failedThirdAttempt) {
      setState(() {
        noOfAttempts = 2;
      });
    } else if (failedSecondAttempt && failedThirdAttempt) {
      setState(() {
        noOfAttempts = 3;
      });
    } else {
      setState(() {
        noOfAttempts = 1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize controllers and focus nodes
    for (int i = 0; i < 20; i++) {
      controllers.add(TextEditingController());
      fieldKeys.add(GlobalKey());
    }
  }

  @override
  void dispose() {
    wordLengthController.dispose();
    firstChoiceController.dispose();
    secondChoiceController.dispose();
    thirdChoiceController.dispose();
    noOfMatchesControllerFirstChoice.dispose();
    noOfMatchesControllerSecondChoice.dispose();
    noOfMatchesControllerThirdChoice.dispose();
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].dispose();
    }
    super.dispose();
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

  void _navigateAndClearResultsList(BuildContext context) async {
    // Navigate to another screen and wait for the result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Results(
                failedSecondAttempt: failedSecondAttempt,
                failedThirdAttempt: failedThirdAttempt,
                listOfWords: listOfWords,
                noOfAttempts: noOfAttempts,
                firstGuessResults: firstGuessResults,
                secondGuessResults: secondGuessResults,
                thirdGuessResults: thirdGuessResults,
              )),
    );

    // Perform action after Navigator.pop
    if (result == true) {
      // Clear the list
      listOfWords.clear();
      listOfNoOfMatchesFirstGuess.clear();
      listOfNoOfMatchesSecondGuess.clear();
      listOfNoOfMatchesThirdGuess.clear();
      firstGuessResults.clear();
      secondGuessResults.clear();
      thirdGuessResults.clear();
    }
  }
  void _navigateAndClearAnalysisList(BuildContext context) async {
    // Navigate to another screen and wait for the result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AnalysisResult(
                groupWords(removeEmptyStrings(listOfWords)),
          )),
    );
    // Perform action after Navigator.pop
    if (result == true) {
      // Clear the list
      listOfWords.clear();
      listOfNoOfMatchesFirstGuess.clear();
      listOfNoOfMatchesSecondGuess.clear();
      listOfNoOfMatchesThirdGuess.clear();
      firstGuessResults.clear();
      secondGuessResults.clear();
      thirdGuessResults.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Analysis'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          CustomNumberTextfield(
              textController: wordLengthController,
              unChanged: (value) {
                setState(() {
                  wordLength = int.parse(value);
                });
              },
              hintText: 'Word length '),
          addVerticalSpacing(10),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: ElevatedButton(
              onPressed: () {
                for (int i = 0; i < controllers.length; i++) {
                  controllers[i].clear();
                }
                wordLengthController.clear();
                setState(() {
                  failedSecondAttempt = false;
                  failedThirdAttempt = false;
                  noOfAttempts = 1;
                  listOfWords.clear();
                  listOfNoOfMatchesFirstGuess.clear();
                  listOfNoOfMatchesSecondGuess.clear();
                  listOfNoOfMatchesThirdGuess.clear();
                  noOfMatchesControllerFirstChoice.clear();
                  noOfMatchesControllerSecondChoice.clear();
                  noOfMatchesControllerThirdChoice.clear();
                  firstChoiceController.clear();
                  secondChoiceController.clear();
                  thirdChoiceController.clear();
                });
              },
              child: const Text('Clear all'),
            ),
          ),
          addVerticalSpacing(20),
          CustomTextfield(
              textController: firstChoiceController,
              maxLength: wordLength,
              wordKey: firstChoiceKey,
              hintText: 'Enter the first guess'),
          CustomNumberTextfield(
              unChanged: (value) {
                setState(() {
                  noOfMatchesFirstChoice = int.parse(value);
                });
              },
              textController: noOfMatchesControllerFirstChoice,
              hintText: 'No of matching letters '),
          addVerticalSpacing(10),
          const Center(
            child: Text(
                'Enter the other words shown on the game below apart from the first choice'),
          ),
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controllers.length,
              itemBuilder: (context, index) {
                return CustomTextfield(
                  textController: controllers[index],
                  wordKey: fieldKeys[index],
                  maxLength: wordLength,
                  hintText: 'Word ${index + 1}',
                );
              }),
          addVerticalSpacing(50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Failed the second guess?'),
                // button to add second choice and no of matching letters
                TextButton(
                  onPressed: () {
                    setState(() {
                      failedSecondAttempt = !failedSecondAttempt;
                      listOfNoOfMatchesFirstGuess = [];
                      listOfNoOfMatchesSecondGuess = [];
                      listOfNoOfMatchesThirdGuess = [];
                    });
                  },
                  child: failedSecondAttempt == false
                      ? const Text('Yes')
                      : const Text('No'),
                ),
              ],
            ),
          ),
          Visibility(
            visible: failedSecondAttempt,
            child: Column(
              children: [
                CustomTextfield(
                    textController: secondChoiceController,
                    maxLength: wordLength,
                    wordKey: secondChoiceKey,
                    hintText: 'Enter the second guess'),
                CustomNumberTextfield(
                    unChanged: (value) {
                      setState(() {
                        noOfMatchesSecondChoice = int.parse(value);
                      });
                    },
                    textController: noOfMatchesControllerSecondChoice,
                    hintText: 'No of matching letters '),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Failed the third guess?'),
                // button to add second choice and no of matching letters
                TextButton(
                  onPressed: () {
                    setState(() {
                      failedThirdAttempt = !failedThirdAttempt;
                      listOfNoOfMatchesFirstGuess = [];
                      listOfNoOfMatchesSecondGuess = [];
                      listOfNoOfMatchesThirdGuess = [];
                    });
                  },
                  child: failedThirdAttempt == false
                      ? const Text('Yes')
                      : const Text('No'),
                ),
              ],
            ),
          ),
          Visibility(
            visible: failedThirdAttempt,
            child: Column(
              children: [
                CustomTextfield(
                    textController: thirdChoiceController,
                    maxLength: wordLength,
                    wordKey: thirdChoiceKey,
                    hintText: 'Enter the third guess'),
                CustomNumberTextfield(
                    unChanged: (value) {
                      setState(() {
                        noOfMatchesThirdChoice = int.parse(value);
                      });
                    },
                    textController: noOfMatchesControllerThirdChoice,
                    hintText: 'No of matching letters '),
              ],
            ),
          ),
          addVerticalSpacing(40),
          ReusableButton(
            const Text('Predict'),
            () {
              // analysis happens here

              if (noOfMatchesControllerFirstChoice.text.isEmpty ||
                  firstChoiceController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('First field must not be empty')),
                );
                return;
              }

              if (failedSecondAttempt &&
                  noOfMatchesControllerSecondChoice.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Second field must not be empty')),
                );
                return;
              }
              if (failedSecondAttempt && secondChoiceController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Second field must not be empty')),
                );
                return;
              }

              if (failedThirdAttempt &&
                  noOfMatchesControllerThirdChoice.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Third field must not be empty')),
                );
                return;
              }
              if (failedThirdAttempt && thirdChoiceController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Second field must not be empty')),
                );
                return;
              }

              // If all conditions are met, process words
              for (int i = 0; i < 20; i++) {
                listOfWords.add(controllers[i].text);
                listOfNoOfMatchesFirstGuess.add(countMatchingLetters(
                    firstChoiceController.text, controllers[i].text));
                if (failedSecondAttempt == true) {
                  listOfNoOfMatchesSecondGuess.add(countMatchingLetters(
                      secondChoiceController.text, controllers[i].text));
                }
                if (failedThirdAttempt == true) {
                  listOfNoOfMatchesThirdGuess.add(countMatchingLetters(
                      thirdChoiceController.text, controllers[i].text));
                }
              }
              upDateNoOfAttempts();
              firstGuessResults = compareIntToList(
                  noOfMatchesFirstChoice, listOfNoOfMatchesFirstGuess);
              if (failedSecondAttempt == true) {
                secondGuessResults = compareIntToList(
                    noOfMatchesSecondChoice, listOfNoOfMatchesSecondGuess);
              }
              if (failedThirdAttempt == true) {
                thirdGuessResults = compareIntToList(
                    noOfMatchesThirdChoice, listOfNoOfMatchesThirdGuess);
              }
              _navigateAndClearResultsList(context);
            },
            Colors.blue,
          ),
          addVerticalSpacing(50),
          ReusableButton(const Text('Analyse'), () {
            for (int i = 0; i < 20; i++) {
              listOfWords.add(controllers[i].text);
            }
            _navigateAndClearAnalysisList(context);
          }, Colors.green),
          addVerticalSpacing(100),
        ],
      ),
    );
  }
}
