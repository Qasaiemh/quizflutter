class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectdOption;

  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectdOption,
  });
}

class Option {
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    required this.isCorrect,
  });
}

final questions=[
  Question(text: 'What is Ramadan?>', options: [
    const Option(text: "Answer 1", isCorrect: false),
    const Option(text: "Answer 2", isCorrect: false),
    const Option(text: "Answer 2", isCorrect: true),
    const Option(text: "Answer 3", isCorrect: false)

  ])
  
  
]
