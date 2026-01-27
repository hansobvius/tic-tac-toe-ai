extension ListMap<T> on List {
  bool containsElements(List<T> compare) {
    final myList = [...this]..sort();
    final otherList = [...compare]..sort();
    
    for (int i = 0; i < length; i++) {
      if (myList[i] != otherList[i]) return false;
    }
    return true;
  }
}