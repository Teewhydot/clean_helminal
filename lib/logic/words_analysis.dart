
int countMatchingLetters(String str1, String str2) {
  // Check if the lengths of the strings are equal
  int matches = 0;
// set matches = -1 to demonstrate that string 2 is empty

  if (str2.isEmpty) {
    matches = -1;
  } else {
    // Initialize a variable to store the number of matching letters

    // Iterate through each character in both strings simultaneously
    for (int i = 0; i < str1.length; i++) {
      // Check if the characters at the same position in both strings match
      if (str1[i] == str2[i]) {
        // If they match, increment the count of matching letters
        matches++;
      }
    }

    // Return the number of matching letters
  }

  return matches;
}

List<List<String>> groupWords(List<String> words) {
  if (words.isEmpty) return [];

  List<List<String>> result = [];
  int wordLength = words[0].length;

  for (int i = 0; i < wordLength; i++) {
    Map<String, List<String>> groups = {};

    // Group words by the character at the current position
    for (var word in words) {
      String key = word[i];
      if (!groups.containsKey(key)) {
        groups[key] = [];
      }
      groups[key]?.add(word);
    }

    // Add groups that have common matching letters to the result list
    groups.forEach((key, group) {
      if (group.length > 1) {
        result.add(group);
      }
    });
  }

  // Remove duplicates from the result list
  List<List<String>> uniqueResults = [];
  for (var group in result) {
    if (!uniqueResults.any((element) => _isSameGroup(element, group))) {
      uniqueResults.add(group);
    }
  }

  return uniqueResults;
}

bool _isSameGroup(List<String> group1, List<String> group2) {
  if (group1.length != group2.length) return false;
  for (var word in group1) {
    if (!group2.contains(word)) return false;
  }
  return true;
}


List<String> removeEmptyStrings(List<String> words) {
  words.removeWhere((word) => word.isEmpty);
  return words;
}

Map<String, int> countStringOccurrences(List<List<String>> listOfLists) {
  Map<String, int> stringOccurrences = {};

  for (List<String> list in listOfLists) {
    for (String str in list) {
      stringOccurrences[str] = (stringOccurrences[str] ?? 0) + 1;
    }
  }

  return stringOccurrences;
}