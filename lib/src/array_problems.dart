class ArrayProblems {
  bool binarySearch(List<int> array, int target) {
    if (array.isEmpty) return false;

    if (array.length == 1) return array.first == target;

    final midIndex = array.length ~/ 2;
    final midValue = array[midIndex];

    if (midValue > target) {
      return binarySearch(array.sublist(0, midIndex), target);
    }

    if (midValue <= target) {
      return binarySearch(array.sublist(midIndex), target);
    }

    return false;
  }

  bool binarySearch2d(List<List<int>> array, int target) {
    if (array.isEmpty) return false;

    if (array.length == 1) return binarySearch(array.first, target);

    final midIndex = array.length ~/ 2;
    final midRow = array[midIndex];

    if (midRow.first > target) {
      return binarySearch2d(array.sublist(0, midIndex), target);
    }

    if (midRow.first <= target) {
      return binarySearch2d(array.sublist(midIndex), target);
    }

    return false;
  }
}
