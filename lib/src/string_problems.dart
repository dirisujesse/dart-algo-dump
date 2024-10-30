import 'dart:io';
import 'dart:math';

import 'package:algorithms/src/structures/stack.dart';

typedef OnUpdated<T> = Function(T value);

class StringProblems {
  (String, String) _getStringPair([bool normalize = true]) {
    stdout.writeln('Enter first String input:');
    String s1 = (stdin.readLineSync() ?? "").trim();
    stdout.writeln('Enter second String input:');
    String s2 = (stdin.readLineSync() ?? "").trim();

    if (normalize) {
      s1 = s1.toLowerCase();
      s2 = s2.toLowerCase();
    }

    return (s1, s2);
  }

  String _getString([bool normalize = true]) {
    stdout.writeln('Enter String input:');
    String input = (stdin.readLineSync() ?? "").trim();

    if (normalize) input = input.toLowerCase();

    return input;
  }

  bool isPalindrome([String? text]) {
    final input = text ?? _getString();

    if (input.isEmpty) {
      stdout.writeln('The input is not a Palindrome');
      return false;
    }

    final maxIndex = input.length - 1;
    final midPoint = input.length ~/ 2;

    for (int i = 0; i < midPoint; ++i) {
      final current = input[i];
      final opposite = input[maxIndex - i];

      if (current != opposite) {
        stdout.writeln('The input $input is not a Palindrome');
        return false;
      }
    }

    stdout.writeln('The input $input is a Palindrome');
    return true;
  }

  bool isValidPalindrome() {
    String input = _getString();

    if (input.isEmpty) {
      stdout.writeln('The input $input is not a valid Palindrome');
      return false;
    }

    stdout.writeln('The input is $input');

    input = input.replaceAll(RegExp(r"[^A-Za-z0-9]"), "").trim();

    stdout.writeln('The input is now $input');

    return isPalindrome(input);
  }

  String reverse() {
    String input = _getString();

    if (input.isEmpty) {
      stdout.writeln('Cannot reverse an empty string');
      return "";
    }

    List<String> reverseHolder = List.filled(input.length, '');

    final maxIndex = input.length - 1;
    final midPoint = input.length ~/ 2;

    for (int i = 0; i < midPoint; i++) {
      final oppositeIndex = maxIndex - i;

      final current = input[i];
      final opposite = input[oppositeIndex];

      reverseHolder[i] = opposite;
      reverseHolder[oppositeIndex] = current;
    }

    final output = reverseHolder.join();

    stdout.writeln('Reversed String output is $output');

    return output;
  }

  bool isAnagram() {
    final (s1, s2) = _getStringPair();

    if (s1.isEmpty || s2.isEmpty) {
      stdout.writeln('Cannot test if anagram on empty strings');
      return false;
    }

    if (s1.length != s2.length) {
      stdout.writeln(
        'Cannot test if anagram string with mismatched length i.e ($s1, $s2)',
      );
      return false;
    }

    Map<String, int> charRegister = {};

    for (int i = 0; i < s1.length; i++) {
      _updateCharCountInMap(charRegister, s1[i]);
    }

    for (int i = 0; i < s2.length; i++) {
      _updateCharCountInMap(charRegister, s2[i], decreaseIfPresent: true);
    }

    stdout.writeln('Resulting register is $charRegister');

    final hasNonZeroValue = charRegister.values.any((it) => it >= 1);

    stdout.writeln(
      'The inputs ($s1, $s2) are${hasNonZeroValue ? ' not ' : ' '}Anagrams',
    );

    return !hasNonZeroValue;
  }

  Iterable<MapEntry<String, int>>? findDuplicates() {
    final input = _getString();

    if (input.isEmpty) {
      stdout.writeln('Cannot find duplicated on an empty String');
      return null;
    }

    if (input.length <= 1) {
      stdout.writeln(
          'Cannot find duplicated on a String with only one character');
      return null;
    }

    Map<String, int> charRegister = {};

    for (int i = 0; i < input.length; i++) {
      _updateCharCountInMap(charRegister, input[i]);
    }

    stdout.writeln('Resulting register is $charRegister');

    final entryWithMultiInstance =
        charRegister.entries.where((it) => it.value > 1);

    stdout.writeln(
      'The input $input has${entryWithMultiInstance.isEmpty ? ' no ' : ' '}duplicate',
    );

    if (entryWithMultiInstance.isNotEmpty) {
      stdout.writeln(
        'The duplicates are $entryWithMultiInstance',
      );
    }
    return entryWithMultiInstance;
  }

  bool isRotation() {
    final (s1, s2) = _getStringPair();

    if (s1.isEmpty || s2.isEmpty) {
      stdout.writeln('Cannot test if rotation on empty strings');
      return false;
    }

    final concactenatedString = s1 + s1;

    stdout.writeln(
      'Concatented string is $concactenatedString',
    );

    final pattern = RegExp(s2);

    final isRotation = pattern.hasMatch(concactenatedString);

    stdout.writeln(
      'The input $s2 is${!isRotation ? ' not ' : ' '}a rotation of $s1',
    );

    return isRotation;
  }

  bool isValidParentheses() {
    final input = _getString();
    final pattern = RegExp(r"[\{\}\(\)\[\]]");

    stdout.writeln(
      [
        ...pattern
            .allMatches(input)
            .map((it) => input.substring(it.start, it.end))
      ],
    );

    if (input.isEmpty || !pattern.hasMatch(input)) {
      stdout.writeln(
        'Cannot test for valid parentheses, $input is empty or has no parentheses character',
      );
      return false;
    }

    final startMap = {"[": "]", "(": ")", "{": "}"};
    final endMap = {"]": "[", ")": "(", "}": "{"};

    final charRegister = Stack<String>();

    for (final char in input.split("")) {
      if (!pattern.hasMatch(input)) continue;
      final isIntialParenthesis = startMap.containsKey(char);
      final isTerminalParenthesis = endMap.containsKey(char);
      final correspondentChar =
          isTerminalParenthesis ? endMap[char] : startMap[char];
      final lastItemInRegister =
          charRegister.isEmpty ? null : charRegister.peek;

      if (isTerminalParenthesis && lastItemInRegister != correspondentChar) {
        stdout.writeln(
          'Invalid Parenthesis pair identified $lastItemInRegister$char are not a valid pair',
        );
        return false;
      }

      if (isTerminalParenthesis && lastItemInRegister == correspondentChar) {
        charRegister.pop();
        continue;
      }

      if (isIntialParenthesis) {
        charRegister.push(char);
        continue;
      }
    }

    final isValid = charRegister.isEmpty;

    stdout.writeln(
      'The input $input does${!isValid ? ' not ' : ' '}contain valid bracket pairs',
    );

    return isValid;
  }

  _updateCharCountInMap(
    Map<String, int> map,
    String key, {
    bool decreaseIfPresent = false,
    OnUpdated? onUpdated,
  }) {
    final hasKey = map.containsKey(key);
    final currentValue = map[key] ?? 0;

    if (decreaseIfPresent && hasKey) {
      map[key] = max(0, currentValue - 1);
      return;
    }

    map[key] = currentValue + 1;

    if (onUpdated != null) {
      onUpdated(map);
    }
  }
}
