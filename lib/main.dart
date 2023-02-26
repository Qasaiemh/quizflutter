import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/fawanees.dart';
import 'package:untitled/model.dart';

import 'util/localization/Translations.dart';
import 'package:lottie/lottie.dart';

bool firstRun = true;

enum Direction { vertical, horizontal }

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
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            Translations.of(context)!.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          elevation: 0,
        ),
        body: Stack(
          children: [
            isDarkMode
                ? SvgPicture.asset(
                    'assets/images/bg_fawanees_dark.svg',
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/bg_athkar.png',
                    fit: BoxFit.cover,
                  ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [],
              ),
            ),
            Container(
              width: double.infinity,
              child: isDarkMode
                  ? Lottie.asset(
                      "assets/images/animated_bg_dark.json",
                      repeat: false,
                      fit: BoxFit.fitWidth,
                    )
                  : Lottie.asset(
                      "assets/images/animated_bg.json",
                      repeat: false,
                      fit: BoxFit.fitWidth,
                    ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 50),
                TileWidget(numberOfDay: 2),
                const SizedBox(height: 100),
                Expanded(child: ListViewStateFull(setElevatedButton)),
              ],
            ),
          ],
        ),
      ),
    );
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
        padding: const EdgeInsets.only(right: 0, left: 0, top: 15, bottom: 15),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset(
            'assets/images/artwork_fawanees.png',
            width: width/6,
            height: width/5,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SlideFadeTransition(
                delayStart: Duration(milliseconds: 200),
                offset: 2,
                direction: Direction.horizontal,
                child: Text(
                  "${Translations.of(context)!.numberOfRamadanDay} $numberOfDay",
                  style: Theme.of(context).textTheme.titleMedium,
                )),
            SlideFadeTransition(
              delayStart: Duration(milliseconds: 200),
              offset: 2,
              direction: Direction.horizontal,
              child: Expanded(
                child: Container(
                  width:width*.75 ,
                  margin: EdgeInsets.only(top: 10,right: 15, bottom: 10, left: 0),
                  //You can use EdgeInsets like above
                  child: Text(
                    overflow: TextOverflow.clip,
                    Translations.of(context)!.fawaneesDescription,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
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

enum Answer {
  none,
  checked,
  correct,
  wrong,
}

class ListViewHome extends State<ListViewStateFull> {
  @override
  void initState() {
    super.initState();
  }

  Answer answer = Answer.none;

  int _selectedIndex = -1;

  static bool isScreenBlocked = false;

  Color selectedColorCorrectBgGreen = const Color(0xFF55DD53);
  Color wrongBottomSheetBg = const Color(0xFF333333);

  Color selectedColorOrange = const Color(0xFFF16E01);
  Color selectedColorRed = const Color(0xFFF03434);
  Color unSelectedColor2 = const Color(0xFF9E9E9E);

  _onSelected(int index) {
    setState(() => {_selectedIndex = index, answer = Answer.checked});
    widget.setElevatedButton();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color selectedColorCorrectBgWhite =
        isDarkMode ? Colors.black : Color(0xFFFFFFFF);

    Color themeColor = isDarkMode ? Color(0xFF2F2F2F) : Color(0xFFFFFFFF);

    return Scaffold(
      backgroundColor: Colors.transparent,
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
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 15, right: 15),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 2))
                            ],
                            border: Border.all(
                                color: _selectedIndex != null &&
                                        _selectedIndex == index
                                    ? (answer == Answer.none
                                        ? selectedColorOrange
                                        : answer == Answer.correct
                                            ? selectedColorCorrectBgGreen
                                            : selectedColorRed)
                                    : selectedColorCorrectBgWhite),
                            borderRadius: BorderRadius.circular(10),
                            color: themeColor),
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
                                      answer != Answer.none &&
                                      answer == Answer.correct
                                  ? SvgPicture.asset(
                                      'assets/images/icon_correct.svg')
                                  : _selectedIndex != null &&
                                          _selectedIndex == index &&
                                          answer == Answer.correct
                                      ? SvgPicture.asset(
                                          'assets/images/icon_correct.svg')
                                      : _selectedIndex == index &&
                                              answer == Answer.wrong
                                          ? SvgPicture.asset(
                                              'assets/images/icon_wrong.svg')
                                          : _selectedIndex == index &&
                                                  answer == Answer.checked
                                              ? SvgPicture.asset(
                                                  'assets/images/radio_checked.svg')
                                              : SvgPicture.asset(
                                                  'assets/images/radio_unchecked.svg')),
                          // No matter how big it is, it won't overflow
                          title: Text(
                            questions.options[index].text,
                            style: TextStyle(
                              fontSize: 17,
                              color: answer == Answer.correct &&
                                      _selectedIndex == index
                                  ? selectedColorCorrectBgGreen
                                  : answer == Answer.correct &&
                                          _selectedIndex == index &&
                                          answer == Answer.correct
                                      ? selectedColorCorrectBgGreen
                                      : answer == Answer.checked &&
                                              _selectedIndex == index
                                          ? selectedColorOrange
                                          : answer == Answer.correct &&
                                                  _selectedIndex == index
                                              ? selectedColorCorrectBgGreen
                                              : answer == Answer.wrong &&
                                                      _selectedIndex == index
                                                  ? selectedColorRed
                                                  : isDarkMode
                                                      ? Colors.white
                                                      : Colors.black,
                              fontWeight: FontWeight.normal,
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
          AbsorbPointer(
            absorbing: isScreenBlocked,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: double.infinity, minHeight: 34),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: answer == Answer.checked
                          ? Colors.white
                          : Color(0xFFBABABA),
                      //change background color of button
                      backgroundColor:
                          (_selectedIndex != null && _selectedIndex != -1)
                              ? selectedColorOrange
                              : unSelectedColor2,
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
                            answer = Answer.correct;
                          });
                          Timer(const Duration(milliseconds: 500), () {
                            showModalBottomSheet<void>(
                              backgroundColor: themeColor,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        const Padding(
                                            padding: EdgeInsets.all(2)),
                                        Text(
                                          'New Fanows had been added \nfor you',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.all(2)),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 7),
                                          child: Center(
                                            child: ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  minWidth: double.infinity,
                                                  minHeight: 34),
                                              child: OutlinedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    side: BorderSide(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        width: 1.0),
                                                    //change background color of button
                                                    //change text color of button
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'REDEEM FAWANEES',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                FawaneesWidget()),
                                                      )),
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
                                                        BorderRadius.circular(
                                                            5),
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
                                        const Padding(
                                            padding: EdgeInsets.all(7)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          });
                        } else {
                          setState(() {
                            answer = Answer.wrong;
                            Timer(const Duration(milliseconds: 500), () {
                              showModalBottomSheet<void>(
                                backgroundColor: themeColor,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            'Wrong Answer',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(2)),
                                          Text(
                                            'We hope you get a correct answer \nnext time.',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(2)),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 10),
                                            child: Center(
                                              child: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth:
                                                            double.infinity,
                                                        minHeight: 34),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        selectedColorOrange,
                                                    //change background color of button
                                                    //change text color of button
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Done',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(7)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                          });
                        }
                      }
                    },
                    child: Text(Translations.of(context)!.confirm),
                  ),
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

class ShapeTransitionWidget extends StatefulWidget {
  const ShapeTransitionWidget({super.key});

  @override
  State<ShapeTransitionWidget> createState() => _ShapeTransitionState();
}

class _ShapeTransitionState extends State<ShapeTransitionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _animationFade;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });

    _animationFade = Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: _animationController,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    double maxSide = size.longestSide;
    return Stack(
      children: [
        AnimatedBuilder(
            animation: _animationFade,
            builder: (context, widget) => Positioned(
                top: 1000,
                child: Transform.scale(
                  scale: _animationFade.value,
                  child: Container(
                    width: maxSide,
                    height: maxSide,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(maxSide),
                      color: Colors.red,
                    ),
                  ),
                )))
      ],
    );
  }
}
