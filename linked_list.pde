class Node {
  Barrier value;
  Node next;
  Node prev;
  
  Node (Barrier value) {
    this.value = value;
    this.next = null;
    this.prev = null;
  }
}


// List used to store barriers
class List {
  Node header = new Node (null);
  
  List () {
    header.next = null;
    header.prev = null;
  }
  
  // Adds Node a to the end of the linked list, updating the header appropriately
  void add (Node a) {
    // linked list is empty
    if (header.next == null && header.prev == null) {
      header.next = a;
      header.prev = a;
    // Normal add
    } else {
      header.prev.next = a;
      header.prev = header.prev.next;
    }
  }
  
  // Removes the frontmost Node a from the linked list if possible
  void pop () {
    if (header.next != null) {
      header.next = header.next.next;
    } else {
      System.out.println("Error, cannot pop");
    }
  }
}
