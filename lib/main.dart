import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: QuestionWidget()),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late PageController _controller;
  int _questionNumber = 1;
  int _score = 0;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    Color unSelectedColor = const Color(0xFFB7B7B7);
    Color selectedColor = const Color(0xFFF16E01);
    Color whiteColor = const Color(0xFFFFFFFF);

    return MaterialApp(
      home: Container(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              "Fawanees Challenge",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
            elevation: 0,
          ),
          body: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/bg_athkar.png'))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Header(numberOfDay: 2),
                const SizedBox(height: 32),
                Expanded(child: ListViewStateFull(setElevatedButton)),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                //   child: Center(
                //     child: ConstrainedBox(
                //         constraints: const BoxConstraints(
                //             minWidth: double.infinity, minHeight: 34),
                //         child: ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //             foregroundColor: Colors.white,
                //             //change background color of button
                //             backgroundColor: questions.isUnLocked
                //                 ? selectedColor
                //                 : unSelectedColor,
                //             //change text color of button
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(5),
                //             ),
                //           ),
                //           onPressed: () {
                //             if (!questions.isUnLocked) {
                //             } else {}
                //           },
                //           child: const Text('Confirm'),
                //         )),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }

  void setElevatedButton() {
    setState(() {
      questions.isUnLocked = true;
    });
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        if (_questionNumber < questions.options.length) {
          _controller.nextPage(
            duration: const Duration(microseconds: 250),
            curve: Curves.easeInExpo,
          );
          setState(() {
            _questionNumber++;
            _isLocked = false;
          });
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(score: _score),
            ),
          );
        }
      },
      child: Text(_questionNumber < questions.options.length ? 'Next' : 'See'),
    );
  }
}

class Header extends StatelessWidget {
  Header({Key? key, required this.numberOfDay}) : super(key: key);
  int numberOfDay = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 0, left: 0, top: 15, bottom: 15),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset(
            'assets/images/artwork_fawanees.png',
            width: 100,
            height: 100,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Day $numberOfDay",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            const Padding(
              padding: EdgeInsets.all(10), //apply padding to all four sides
            ),
            const Text(
              "is simply dummy text of the \nprinting and typesetting industry ?",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 17),
            )
          ]),
        ]));
  }
}

class ListViewStateFull extends StatefulWidget {
  ListViewStateFull(this.setElevatedButton, {Key? key}) : super(key: key);
  final Function setElevatedButton;

  @override
  ListViewHome createState() => ListViewHome();
}

class ListViewHome extends State<ListViewStateFull> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = -1;
  bool? isCorrect = null;
  Color selectedColor = const Color(0xFFB7B7B7);
  Color selectedColorGreen = const Color(0xFF55DD53);
  Color selectedColorOrange = const Color(0xFFF16E01);
  Color selectedColorRed = const Color(0xFFF03434);
  Color unSelectedColor = const Color(0xFFE0E0E0);

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
    widget.setElevatedButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: questions.options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: _selectedIndex != null && _selectedIndex == index
                          ? 65
                          : 45,
                      // child: _selectedIndex != null &&
                      // _selectedIndex == index &&
                      // isCorrect != null &&
                      // isCorrect!
                      //     ? Icon(Icons.check_circle, color: Colors.green)
                      //     : _selectedIndex != null &&
                      //     _selectedIndex == index &&
                      //     isCorrect != null &&
                      //     !isCorrect!
                      // ? Icon(Icons.check_circle, color: Colors.red)
                      // : null,
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 15),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _selectedIndex != null &&
                                  _selectedIndex == index &&
                                  isCorrect != null &&
                                  isCorrect!
                              ? selectedColorGreen
                              : _selectedIndex != null &&
                                      _selectedIndex == index &&
                                      isCorrect == null
                                  ? unSelectedColor
                                  : _selectedIndex != null &&
                                          _selectedIndex == index &&
                                          isCorrect != null &&
                                          !isCorrect!
                                      ? selectedColorRed
                                      : unSelectedColor),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                            maxWidth: 20,
                            maxHeight: 20,
                          ),
                          child: _selectedIndex != null &&
                                  _selectedIndex == index &&
                                  isCorrect != null &&
                                  isCorrect!
                              ? Image.asset('assets/images/icon_correct.jpg',
                                  fit: BoxFit.fill)
                              : _selectedIndex != null &&
                                      _selectedIndex == index &&
                                      isCorrect != null &&
                                      !isCorrect!
                                  ? Image.asset('assets/images/wrong.png',
                                      fit: BoxFit.fill)
                                  : null,
                        ),
                        // No matter how big it is, it won't overflow
                        title: Align(
                          alignment: const Alignment(-0.9, -0.2),
                          child: Text(
                            questions.options[index].text,
                          ),
                        ),
                        onTap: () => _onSelected(index),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: double.infinity, minHeight: 34),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      //change background color of button
                      backgroundColor:
                          (_selectedIndex != null && _selectedIndex != -1)
                              ? selectedColorOrange
                              : unSelectedColor,
                      //change text color of button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (!questions.isUnLocked) {
                      } else {
                        if (questions.options[_selectedIndex].isCorrect) {
                          setState(() {
                            isCorrect = true;
                          });
                        } else {
                          setState(() {
                            isCorrect = false;
                          });
                        }
                      }
                    },
                    child: const Text('Confirm'),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  getIconForOption(Option option, Question question) {
    final isSelected = option == question.selectdOption;
    if (question.isUnLocked) {
      if (isSelected) {
        return option.isCorrect
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.cancel, color: Colors.red);
      } else if (option.isCorrect) {
        return const Icon(Icons.check_circle, color: Colors.green);
      }
    }
    return const SizedBox.shrink();
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.score}) : super(key: key);
  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('you got $score/${questions.options.length}'),
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;
  double height = 50;

  OptionsWidget(
      {Key? key,
      required this.question,
      required this.onClickedOption,
      required this.height})
      : super(key: key);

  buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);
    return GestureDetector(
        onTap: () => {onClickedOption(option)},
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option.text,
                style: const TextStyle(fontSize: 20),
              ),
              getIconForOption(option, question)
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: question.options
              .map<Widget>((option) => buildOption(context, option))
              .toList(),
        ),
      );

  getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectdOption;
    if (isSelected) {
      return option.isCorrect ? Colors.green : Colors.red;
    } else if (option.isCorrect) {
      return Colors.green;
    }
    return Colors.grey.shade300;
  }

  getIconForOption(Option option, Question question) {
    final isSelected = option == question.selectdOption;
    if (question.isUnLocked) {
      if (isSelected) {
        return option.isCorrect
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.cancel, color: Colors.red);
      } else if (option.isCorrect) {
        return const Icon(Icons.check_circle, color: Colors.green);
      }
    }
    return const SizedBox.shrink();
  }
}
