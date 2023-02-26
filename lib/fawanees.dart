import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/FawaneesModel.dart';

// void main() {
//   runApp(const MyApp());
// }

final List<Fawanees> entries = <Fawanees>[
  Fawanees(
      totalFanwos: "5",
      numberOfFanwos: "5",
      data: "500",
      dataUnit: "MB",
      validty: "Valid for 1 day",
      isLocked: false,
      isAdded: true),
  Fawanees(
      totalFanwos: "30",
      numberOfFanwos: "30",
      data: "1",
      dataUnit: "GB",
      validty: "Valid for 2 day",
      isLocked: false,
      isAdded: false),
  Fawanees(
      totalFanwos: "30",
      numberOfFanwos: "105",
      data: "2",
      dataUnit: "GB",
      validty: "Valid for 7 day",
      isLocked: false,
      isAdded: false),
  Fawanees(
      totalFanwos: "30",
      numberOfFanwos: "200",
      data: "5",
      dataUnit: "GB",
      validty: "Valid for 7 day",
      isLocked: true,
      isAdded: false)
];

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // A fixed-height child.
                  color: const Color(0xffeeee00), // Yellow
                  height: 120.0,
                  alignment: Alignment.center,
                  child: const Text('Fixed Height Content'),
                ),
                ParentListview(0),
                SizedBox(
                  height: 10,
                ),
                ParentListview(1),
              ],
            ),
          );
        },
      ),
    );
  }

  Container ParentListview(int i) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/card_bg_fawanees.png'))),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 30,
        itemBuilder: (context, index) => ListTile(
          title: Text('$i'),
          subtitle: Text("Fawanees"),
        ),
      ),
    );
  }
}

bool firstRun = true;

enum Direction { vertical, horizontal }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: const Scaffold(body: FawaneesWidget()),
    );
  }
}

class FawaneesWidget extends StatefulWidget {
  const FawaneesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FawaneesWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<FawaneesWidget> {
  @override
  void initState() {
    super.initState();
  }

  int numberOfFanwos = 66;
  Color textColorOrange = const Color(0xFFDD9B59);

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.all(5), //apply padding to all four sides
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "My Fawanees:",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(
                              2), //apply padding to all four sides
                        ),
                        Text(
                          '$numberOfFanwos',
                          style: TextStyle(
                              color: textColorOrange,
                              fontWeight: FontWeight.normal,
                              fontSize: 17),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(
                              2), //apply padding to all four sides
                        ),
                        Image.asset(
                          'assets/images/artwork_fawanees.png',
                          width: 25,
                          height: 40,
                        ),
                      ]),
                  Flexible(
                    child: FawaneesState(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FawaneesState extends StatefulWidget {
  FawaneesState({Key? key}) : super(key: key);

  @override
  FawaneesListview createState() => FawaneesListview();
}

class FawaneesListview extends State<FawaneesState> {
  final List<Fawanees> fawaneesDynmicList = <Fawanees>[
    Fawanees(
        totalFanwos: "5",
        numberOfFanwos: "5",
        data: "500",
        dataUnit: "MB",
        validty: "Valid for 1 day",
        isLocked: false,
        isAdded: true),
    Fawanees(
        totalFanwos: "30",
        numberOfFanwos: "30",
        data: "1",
        dataUnit: "GB",
        validty: "Valid for 2 day",
        isLocked: false,
        isAdded: false),
    Fawanees(
        totalFanwos: "30",
        numberOfFanwos: "105",
        data: "2",
        dataUnit: "GB",
        validty: "Valid for 7 day",
        isLocked: false,
        isAdded: false),
    Fawanees(
        totalFanwos: "30",
        numberOfFanwos: "200",
        data: "5",
        dataUnit: "GB",
        validty: "Valid for 7 day",
        isLocked: true,
        isAdded: false)
  ];
  final List<Fawanees> fawaneesStaticList = <Fawanees>[
    Fawanees(
        totalFanwos: "5",
        numberOfFanwos: "200",
        data: "1",
        dataUnit: "Chance",
        validty: "to win on the draw",
        isLocked: false,
        isAdded: true),
    Fawanees(
        totalFanwos: "30",
        numberOfFanwos: "201-250",
        data: "5",
        dataUnit: "Chances",
        validty: "to win on the draw",
        isLocked: false,
        isAdded: false),
    Fawanees(
        totalFanwos: "30",
        numberOfFanwos: ">250",
        data: "10",
        dataUnit: "Chances",
        validty: "to win on the draw",
        isLocked: false,
        isAdded: false)
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color textColorOrange = const Color(0xFFDD9B59);
    Color buttonColorOrange = const Color(0xFFF16E01);
    Color textColorDisabled =
        isDarkMode ? Color(0xFF7C7C7C) : Color(0xFFC4C4C4);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.vertical,
              children: [
                // showing list of images
                for (var item in fawaneesDynmicList)
                  Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            isDarkMode
                                ? Image.asset('assets/images/bg_card_dark.png')
                                : Image.asset('assets/images/bg_card.png'),
                            Container(
                              child: Row(children: [
                                SizedBox(
                                  width: width *0.10,
                                  height: 120,
                                ),
                                Column(children: [
                                  Text(
                                    item.numberOfFanwos,
                                    style: TextStyle(
                                        color: item.isLocked
                                            ? textColorDisabled
                                            : isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(
                                        5), //apply padding to all four sides
                                  ),
                                  Text(
                                    "Fawanees",
                                    style: TextStyle(
                                        color: item.isLocked
                                            ? textColorDisabled
                                            : isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                  )
                                ]),
                                Container(
                                    height: 50,
                                    child: const VerticalDivider(
                                        color: Color(0xFFE0E0E0))),
                                 SizedBox(
                                   width: width *0.05,
                                ),
                                Column(children: [
                                  Row(children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          item.data,
                                          style: TextStyle(
                                              color: item.isLocked
                                                  ? textColorDisabled
                                                  : item.isAdded
                                                      ? (isDarkMode
                                                          ? Colors.white
                                                          : Colors.black)
                                                      : textColorOrange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(
                                          1), //apply padding to all four sides
                                    ),
                                    Text(
                                      item.dataUnit,
                                      style: TextStyle(
                                          color: item.isLocked
                                              ? textColorDisabled
                                              : item.isAdded
                                                  ? (isDarkMode
                                                      ? Colors.white
                                                      : Colors.black)
                                                  : textColorOrange,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 17),
                                    ),
                                    const Text(
                                      "        ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    ),
                                  ]),
                                  const Padding(
                                    padding: EdgeInsets.all(
                                        2), //apply padding to all four sides
                                  ),
                                  Text(
                                    item.validty,
                                    style: TextStyle(
                                        color: item.isLocked
                                            ? textColorDisabled
                                            : (isDarkMode
                                                ? Colors.white
                                                : Colors.black),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ]),
                                 SizedBox(
                                   width: width *0.05,
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFFE0E0E0))),
                                 SizedBox(
                                   width: width *0.05,
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: AutoSizeText(item.isAdded ? "Added" : "Get",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: item.isLocked
                                              ? textColorDisabled
                                              : item.isAdded
                                                  ? (isDarkMode
                                                      ? Colors.white
                                                      : Colors.black)
                                                  : textColorOrange,
                                        )))
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
              height: 1,
              color: const Color(0xFFDDDDDD),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        "Get",
                        style: TextStyle(
                            color: textColorOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                  Text(
                    "The \nChance",
                    style: TextStyle(
                        color: textColorOrange,
                        fontWeight: FontWeight.normal,
                        fontSize: 17),
                  )
                ]),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 15, bottom: 10, left: 5),
                    //You can use EdgeInsets like above
                    child: Text(
                      'Get the chance to win daily prizes, as '
                      'well as smartphones, smartwatches, and cash money, in the '
                      'draw that will take place on 01.05.2023',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.vertical,
              children: [
                // showing list of images
                for (var item in fawaneesStaticList)
                  Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            FittedBox(fit: BoxFit.fitWidth),
                            isDarkMode
                                ? Image.asset('assets/images/bg_card_dark.png')
                                : Image.asset('assets/images/bg_card.png'),
                            Row(children: [
                              const SizedBox(
                                width: 40,
                                height: 120,
                              ),
                              Column(children: [
                                Text(
                                  item.numberOfFanwos,
                                  style: TextStyle(
                                      color: textColorDisabled,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(
                                      5), //apply padding to all four sides
                                ),
                                Text(
                                  "Fawanees",
                                  style: TextStyle(
                                      color: textColorDisabled,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                )
                              ]),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFFE0E0E0))),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(children: [
                                Row(children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        item.data,
                                        style: TextStyle(
                                            color: textColorDisabled,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(
                                        1), //apply padding to all four sides
                                  ),
                                  Text(
                                    item.dataUnit,
                                    style: TextStyle(
                                        color: textColorDisabled,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                  ),
                                  const Text(
                                    "        ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ]),
                                const Padding(
                                  padding: EdgeInsets.all(
                                      2), //apply padding to all four sides
                                ),
                                Text(
                                  item.validty,
                                  style: TextStyle(
                                      color: textColorDisabled,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                              ]),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: double.infinity, minHeight: 34),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      //change background color of button
                      backgroundColor: buttonColorOrange,
                      //change text color of button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Done'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
