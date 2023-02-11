import 'dart:ffi';

class Question {
  final String text;
  final List<Option> options;
  bool isUnLocked;
  double height;
  Option? selectdOption;

  Question(
      {required this.text,
      required this.options,
      this.isUnLocked = false,
      this.selectdOption,
      required this.height});
}

class Option {
  final String text;
  final bool isCorrect;
  final int height;

  const Option({
    required this.text,
    required this.isCorrect,
    required this.height,
  });
}

final questions = Question(
    text: 'What is Ramadan?>',
    options: [
      const Option(text: "Answer 1", isCorrect: false, height: 50),
      const Option(text: "Answer 2", isCorrect: true, height: 50),
      const Option(text: "Answer 3", isCorrect: true, height: 50),
      const Option(text: "Answer 4", isCorrect: false, height: 50),
    ],
    height: 50);
