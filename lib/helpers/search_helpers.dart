String removeExtraInternalWhitespace(str) {
  final RegExp multipleSpaces = RegExp(r'\s+');
  String newStr = str.replaceAll(multipleSpaces, " ");

  return newStr;
}

String removePunctuation(str) {
  String newStr1 = str.replaceAll("'", '');
  RegExp punctuationRegExStr = RegExp(r'([^a-z0-9\s])');
  String newStr2 = newStr1.replaceAll(punctuationRegExStr, ' ');

  return newStr2;
}

String normaliseString(str) {
  //convert to lowercase
  String lowerCaseStr = str.toLowerCase();
  // remove punctuation
  String noPunctuationStr = removePunctuation(lowerCaseStr);
  // remove extra extra internal white space
  String noExtraWhiteSpaceStr = removeExtraInternalWhitespace(noPunctuationStr);
  // remove preceeding and trailing whitespace
  String finalStr = noExtraWhiteSpaceStr.trim();

  return finalStr;
}

int createSearchScore(String searchStr, String productTitle) {

  List<String> searchStrWordList = searchStr.split(" ");
  List<String> productTitleWordList = productTitle.split(" ");

  if (productTitle == searchStr) {
    return 100;
  } else {
    double score = 0;
    double incrementScoreBy = 99 / searchStrWordList.length;

    for (var searchWord in searchStrWordList) {
      if (productTitleWordList.contains(searchWord)) {
        score += incrementScoreBy;
      }
    }

    return score.floor();
  }
}
