extension ListMap<T> on List {
  bool containsElements(List<T> compare) {
    if (length < compare.length) return false;

    return compare.every((element) => contains(element));
  }
}