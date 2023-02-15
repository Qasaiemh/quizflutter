
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/FawaneesModel.dart';

void main() {
  runApp(const MyApp());
}

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

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

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

  int numberOfFanwos = 66;
  Color textColorOrange = const Color(0xFFDD9B59);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/bg_athkar.png'))),
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
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "My Fawanees:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
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
  Color textColorOrange = const Color(0xFFDD9B59);

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

  @override
  Widget build(BuildContext context) {
    // count of the list of image
    var ImgCount = entries.length;

    // MaterialApp with debugShowCheckedModeBanner false
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.vertical,
                children: [
                  // showing list of images
                  for (var item in entries)
                    Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              FittedBox(fit: BoxFit.fitWidth),
                              Image.asset('assets/images/card_bg_fawanees.png'),
                              Row(children: [
                                const SizedBox(
                                  width: 40,
                                  height: 120,
                                ),
                                Column(children: [
                                  Text(
                                    item.numberOfFanwos,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(
                                        5), //apply padding to all four sides
                                  ),
                                  const Text(
                                    "Fawanees",
                                    style: TextStyle(
                                        color: Colors.black,
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
                                              color: item.isAdded
                                                  ? Colors.black
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
                                          color: item.isAdded
                                              ? Colors.black
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
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ]),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFFE0E0E0))),
                                const SizedBox(
                                  width: 40,
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: item.isAdded
                                        ? Text("Added",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black))
                                        : Text("Get",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: textColorOrange)))
                              ]),
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      child: Text(
                        "Get the chance to win daily prizes, as well as \nsmartphones, smartwatches, and cash money, in the \ndraw that will take place on 01.05.2023",
                        style: TextStyle(
                            color: textColorOrange,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
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
                  for (var item in entries)
                    Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              FittedBox(fit: BoxFit.fitWidth),
                              Image.asset('assets/images/card_bg_fawanees.png'),
                              Row(children: [
                                const SizedBox(
                                  width: 40,
                                  height: 120,
                                ),
                                Column(children: [
                                  Text(
                                    item.numberOfFanwos,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(
                                        5), //apply padding to all four sides
                                  ),
                                  const Text(
                                    "Fawanees",
                                    style: TextStyle(
                                        color: Colors.black,
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
                                              color: item.isAdded
                                                  ? Colors.black
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
                                          color: item.isAdded
                                              ? Colors.black
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
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ]),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFFE0E0E0))),
                                const SizedBox(
                                  width: 40,
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: item.isAdded
                                        ? Text("Added",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black))
                                        : Text("Get",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: textColorOrange)))
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
