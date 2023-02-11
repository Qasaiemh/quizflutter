import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/model.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

bool firstRun = true;

enum Direction { vertical, horizontal }

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
  State<QuestionWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<QuestionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                TileWidget(numberOfDay: 2),
                const SizedBox(height: 32),
                Expanded(child: ListViewStateFull(setElevatedButton)),
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
}

class TileWidget extends StatelessWidget {
  TileWidget({Key? key, required this.numberOfDay}) : super(key: key);
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
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            SlideFadeTransition(
                delayStart: Duration(milliseconds: 200),
                offset: 2,
                direction: Direction.horizontal,
                child: Text(
                  "Day 1",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                )),
            Padding(
              padding: EdgeInsets.all(10), //apply padding to all four sides
            ),
            SlideFadeTransition(
                delayStart: Duration(milliseconds: 200),
                offset: 2,
                direction: Direction.horizontal,
                child: Text(
                  "is simply dummy text of the \nprinting and typesetting industry ?",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 17),
                )),
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
  static bool preSelected = false;
  static bool isScreenBlocked = false;

  Color selectedColor = const Color(0xFFB7B7B7);
  Color selectedColorCorrectBgGreen = const Color(0xFFFFFFFF);
  Color selectedColorCorrectBgWhite = const Color(0xFF55DD53);
  Color wrongBottomSheetBg = const Color(0xFF333333);

  Color selectedColorCorrectText =
      preSelected ? const Color(0xFF55DD53) : const Color(0xFFFFFFFF);

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
                    child: SlideFadeTransition(
                  delayStart: Duration(milliseconds: 800),
                  direction: Direction.vertical,
                  offset: 2,
                  child: AbsorbPointer(
                    absorbing: isScreenBlocked,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height:
                            _selectedIndex != null && _selectedIndex == index
                                ? 65
                                : 45,
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 15, right: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: _selectedIndex != null &&
                                        _selectedIndex == index &&
                                        isCorrect != null &&
                                        preSelected
                                    ? selectedColorCorrectBgWhite
                                    : selectedColorCorrectBgGreen),
                            borderRadius: BorderRadius.circular(10),
                            color: _selectedIndex != null &&
                                    _selectedIndex == index &&
                                    isCorrect != null &&
                                    isCorrect!
                                ? preSelected
                                    ? selectedColorCorrectBgGreen
                                    : selectedColorCorrectBgWhite
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
                              minWidth: 24,
                              minHeight: 24,
                              maxWidth: 24,
                              maxHeight: 24,
                            ),
                            child: _selectedIndex != null &&
                                    _selectedIndex == index &&
                                    isCorrect != null &&
                                    isCorrect!
                                ? preSelected
                                    ? SvgPicture.asset(
                                        'assets/images/icon_correct_green.svg')
                                    : SvgPicture.asset(
                                        'assets/images/icon_correct.svg')
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
                            alignment: const Alignment(-1.2, -0.2),
                            child: Text(
                              questions.options[index].text,
                              style: TextStyle(
                                fontSize: 17,
                                color: _selectedIndex != null &&
                                        _selectedIndex == index &&
                                        isCorrect != null
                                    ? preSelected
                                        ? selectedColorCorrectBgWhite
                                        : selectedColorCorrectBgGreen
                                    : Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          onTap: () => _onSelected(index),
                        ),
                      ),
                    ),
                  ),
                ));
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
                          isScreenBlocked = true;
                          isCorrect = true;
                          preSelected = true;
                        });
                        Timer(const Duration(seconds: 2), () {
                          setState(() {
                            preSelected = false;
                          });
                        });

                        Timer(const Duration(seconds: 3), () {
                          showModalBottomSheet<void>(
                            context: context,
                            enableDrag: true,
                            isDismissible: false,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 300,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Padding(
                                          padding: EdgeInsets.all(10)),
                                      Image.asset(
                                        'assets/images/artwork_fawanees.png',
                                        width: 65,
                                        height: 65,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(10)),
                                      const Text(
                                        'Correct Answer',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Padding(padding: EdgeInsets.all(2)),
                                      const Text(
                                        'New Fanows had been added \nfor you',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const Padding(padding: EdgeInsets.all(2)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 7),
                                        child: Center(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                                minWidth: double.infinity,
                                                minHeight: 34),
                                            child: OutlinedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                side: const BorderSide(
                                                    width: 1.0),
                                                //change background color of button
                                                //change text color of button
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              child: const Text(
                                                'REDEEM FAWANEES',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 10),
                                        child: Center(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                                minWidth: double.infinity,
                                                minHeight: 34),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    selectedColorOrange,
                                                //change background color of button
                                                //change text color of button
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              child: const Text(
                                                'Done',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        });
                      } else {
                        setState(() {
                          isCorrect = false;
                          showBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              builder: (context) => Container(
                                    height: 250,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: wrongBottomSheetBg,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0))),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Padding(
                                                  padding: EdgeInsets.all(10)),
                                              const Text(
                                                'Wrong Answer',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.all(10)),
                                              const Text(
                                                'We hope you get a correct answer \nnext time.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.all(10)),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2,
                                                        horizontal: 7),
                                                child: Center(
                                                  child: ConstrainedBox(
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth:
                                                                double.infinity,
                                                            minHeight: 34),
                                                    child: OutlinedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        side: const BorderSide(
                                                            color: Colors.white,
                                                            width: 1.0),
                                                        //change background color of button
                                                        //change text color of button
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'DONE',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ));
                        });
                      }
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideFadeTransition extends StatefulWidget {
  ///The child on which to apply the given [SlideFadeTransition]
  final Widget child;

  ///The offset by which to slide and [child] into view from [Direction].
  ///Defaults to 0.2
  final double offset;

  ///The curve used to animate the [child] into view.
  ///Defaults to [Curves.easeIn]
  final Curve curve;

  ///The direction from which to animate the [child] into view. [Direction.horizontal]
  ///will make the child slide on x-axis by [offset] and [Direction.vertical] on y-axis.
  ///Defaults to [Direction.vertical]
  final Direction direction;

  ///The delay with which to animate the [child]. Takes in a [Duration] and
  /// defaults to 0.0 seconds
  final Duration delayStart;

  ///The total duration in which the animation completes. Defaults to 800 milliseconds
  final Duration animationDuration;

  const SlideFadeTransition({
    required this.child,
    this.offset = 0.2,
    this.curve = Curves.easeIn,
    required this.direction,
    this.delayStart = const Duration(seconds: 0),
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  _SlideFadeTransitionState createState() => _SlideFadeTransitionState();
}

class _SlideFadeTransitionState extends State<SlideFadeTransition>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animationSlide;

  late AnimationController _animationController;

  late Animation<double> _animationFade;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    //configure the animation controller as per the direction
    if (widget.direction == Direction.vertical) {
      _animationSlide =
          Tween<Offset>(begin: Offset(0, widget.offset), end: Offset(0, 0))
              .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    } else {
      _animationSlide =
          Tween<Offset>(begin: Offset(widget.offset, 0), end: Offset(0, 0))
              .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    }

    _animationFade =
        Tween<double>(begin: -1.0, end: 1.0).animate(CurvedAnimation(
      curve: widget.curve,
      parent: _animationController,
    ));

    Timer(widget.delayStart, () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return firstRun
        ? FadeTransition(
            opacity: _animationFade,
            child: SlideTransition(
              position: _animationSlide,
              child: widget.child,
            ),
          )
        : widget.child;
  }
}
