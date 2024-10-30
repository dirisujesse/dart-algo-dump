class Stack<T> {
  final List<T> _storage;

  Stack() : _storage = <T>[];

  Stack.of(Iterable<T> elements) : _storage = List<T>.of(elements);

  void push(T member) {
    _storage.add(member);
  }

  T pop() => _storage.removeLast();

  T get peek => _storage.last;

  bool get isEmpty => _storage.isEmpty;

  bool get isNotEmpty => _storage.isNotEmpty;

  @override
  String toString() {
    return '--- Top ---\n${_storage.reversed.join('\n')}\n-----------';
  }
}
