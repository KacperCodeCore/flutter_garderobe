class ListManager<T> {
  List<T> elementList = [];

  void addElement(T element) {
    elementList.add(element);
  }

  void removeElement(T element) {
    elementList.remove(element);
  }

  void editElement(int index, T newElement) {
    if (index >= 0 && index < elementList.length) {
      elementList[index] = newElement;
    }
  }
}
