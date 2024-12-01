import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String mathOperation = '0';
  String result = '0';

  final calcButtons = [
    '7',
    '8',
    '9',
    'C',
    'AC',
    '4',
    '5',
    '6',
    '+',
    '-',
    '1',
    '2',
    '3',
    '*',
    '/',
    '0',
    '.',
    '00',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          centerTitle: true,
          title: const Text(
            'Calculator',
            style: TextStyle(fontSize: 26, letterSpacing: 2),
          ),
          elevation: 1,
        ),
        body: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                myText(screenSize, mathOperation),
                myText(screenSize, result),
              ],
            )),
            Expanded(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                    ),
                    child: createGrid(screenSize))),
          ],
        ),
      ),
    );
  }

  Widget createGrid(screenSize) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio:
                (MediaQuery.of(context).orientation == Orientation.portrait)
                    ? (screenSize.width / 5) / ((screenSize.height * 0.59) / 4)
                    : (screenSize.width / 5) / ((screenSize.height * 0.5) / 4),
            crossAxisCount: 5),
        itemCount: calcButtons.length,
        itemBuilder: (context, index) => calculatorButtons(calcButtons[index]),
      ),
    );
  }

  Widget calculatorButtons(value) {
    return GestureDetector(
      onTap: () {
        print(value);
      },
      child: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: colorButtons(value),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          value,
          style: TextStyle(
              fontSize: 20,
              color: textColor(value),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget myText(screenSize, valueue) {
    return Container(
      width: screenSize.width,
      height: screenSize.height / 10,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.bottomRight,
      child: Text(
        valueue,
        style: TextStyle(
            fontSize:
                (MediaQuery.of(context).orientation == Orientation.portrait)
                    ? 52
                    : 22,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Color colorButtons(value) {
    if (value == 'AC' || value == 'C') {
      return const Color.fromRGBO(54, 140, 206, 1);
    }
    if (value == '*' ||
        value == '-' ||
        value == '/' ||
        value == '=' ||
        value == '+') {
      return const Color.fromRGBO(226, 218, 214, 1);
    }
    return const Color.fromRGBO(100, 130, 173, 1);
  }

  Color textColor(value) {
    if (value == '*' ||
        value == '-' ||
        value == '/' ||
        value == '=' ||
        value == '+') {
      return Colors.black;
    }
    return Colors.white;
  }
}
