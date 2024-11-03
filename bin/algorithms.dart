import 'dart:io';

import 'package:algorithms/algorithms.dart';
import 'package:args/args.dart';

void main(List<String> arguments) {
  try {
    final parser = ArgParser()
      ..addOption("string-problem",
          abbr: "s",
          allowed: [
            "isPalindrome",
            "isValidPalindrome",
            "reverse",
            "isRotation",
            "findDuplicates",
            "isAnagram",
            "validParentheses",
          ],
          defaultsTo: "isPalindrome",
          help: "Execute a number of common string algorithms",
          allowedHelp: {
            "isPalindrome": "Check if string is palidrome",
            "isValidPalindrome": "Check if string is valid palidrome",
            "reverse": "Reverses a string",
            "isRotation": "Check if string pair are a rotation",
            "isAnagram": "Check if string pair are anagrams",
            "findDuplicates": "Prints out duplicates in string",
            "validParentheses": "Check if string has valid parentheses",
          })
      ..addOption(
        "array-problem",
        abbr: "a",
        allowed: [
          "search",
        ],
        help: "Execute a number of common array algorithms",
      )
      ..addFlag(
        "help",
        abbr: "h",
        help: "Prints help message",
        defaultsTo: true,
        negatable: false,
      );

    final results = parser.parse(arguments);

    if (results.wasParsed("array-problem")) {
      final target = 60;
      final array2d = [
        [1, 3, 5, 7],
        [10, 11, 16, 20],
        [23, 30, 34, 60]
      ];

      final isInArray = ArrayProblems().binarySearch(array2d[2], target);

      final isIn2dArray = ArrayProblems().binarySearch2d(array2d, target);

      stdout.writeln(
        "$target can${isInArray ? '' : 'not'} be found in ${array2d[2]}",
      );

      stdout.writeln(
        "$target can${isIn2dArray ? '' : 'not'} be found in $array2d",
      );

      return;
    }
    if (results.wasParsed("string-problem")) {
      final arg = results.arguments.last;
      final sp = StringProblems();

      switch (arg) {
        case "reverse":
          sp.reverse();
          break;
        case "isRotation":
          sp.isRotation();
          break;
        case "findDuplicates":
          sp.findDuplicates();
          break;
        case "isAnagram":
          sp.isAnagram();
          break;
        case "validParentheses":
          sp.isValidParentheses();
          break;
        case "isValidPalindrome":
          sp.isValidPalindrome();
          break;
        default:
          sp.isPalindrome();
      }

      return;
    }
  } catch (e) {
    stdout.writeln("We encoutered and error $e, executing your command");
  }
}
