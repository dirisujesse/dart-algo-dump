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
      ..addFlag(
        "help",
        abbr: "h",
        help: "Prints help message",
        defaultsTo: true,
        negatable: false,
      );

    final results = parser.parse(arguments);

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
