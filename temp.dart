void main() {
  student matt = student("Matt");
  print(matt.name);
  matt.sayHi();
  smartStudent derek = smartStudent("Derek");
  print(derek.name);
  derek.sayHi();
}

class student {
  String name = "";

  student(String name) {
    this.name = name;
  }
  void sayHi() {
    print("$name say hi");
  }
}

class smartStudent extends student {
  smartStudent(String name) : super(name);
}
