import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String mathOperation = '';
  String result = '';
  final ScrollController _opertaionScrollController = ScrollController();

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
                operationText(
                    screenSize, mathOperation, _opertaionScrollController),
                resultText(
                  screenSize,
                  result,
                ),
              ],
            )),
            Expanded(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
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
        pressButton(value);
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

  Widget operationText(screenSize, valueue, scrollController) {
    return Container(
      width: screenSize.width,
      height: screenSize.height / 10,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.bottomRight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              valueue,
              style: TextStyle(
                fontSize:
                    (MediaQuery.of(context).orientation == Orientation.portrait)
                        ? 52
                        : 22,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }

  Widget resultText(
    screenSize,
    valueue,
  ) {
    return Container(
      width: screenSize.width,
      height: screenSize.height / 10,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.bottomRight,
      child: AutoSizeText(
        result,
        style: TextStyle(
          fontSize: (MediaQuery.of(context).orientation == Orientation.portrait)
              ? 52
              : 22,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        maxFontSize: 52,
        minFontSize:
            10, // Minimum font size to prevent the text from becoming too small
        overflow: TextOverflow.ellipsis,
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

  pressButton(value) {
    if ((value == '*' ||
            value == '/' ||
            value == '=' ||
            value == 'C' ||
            value == 'AC') &&
        mathOperation.isEmpty) {
      return;
    }
    if (value == '=' && mathOperation.isNotEmpty) {
      if (mathOperation.length == 1 && isOperationSign(mathOperation[0]))
        return;
      if (isOperationSign(mathOperation[mathOperation.length - 1])) {
        setState(() {
          mathOperation = mathOperation.substring(0, mathOperation.length - 1);
        });
      }
      calculate();
      return;
    }
    if (value == 'C' && mathOperation.isNotEmpty) {
      setState(() {
        mathOperation = mathOperation.substring(0, mathOperation.length - 1);
      });
      return;
    }
    if (value == 'AC') {
      setState(() {
        mathOperation = '';
        result = '';
      });
      return;
    }
    if ((value == '*' || value == '-' || value == '/' || value == '+') &&
        mathOperation.isNotEmpty &&
        isOperationSign(mathOperation[mathOperation.length - 1])) {
      return;
    }
    setState(() {
      mathOperation += value;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_opertaionScrollController.hasClients) {
        _opertaionScrollController
            .jumpTo(_opertaionScrollController.position.maxScrollExtent);
      }
    });
  }

  isOperationSign(value) {
    if (value == '*' ||
        value == '-' ||
        value == '/' ||
        value == '.' ||
        value == '+') {
      return true;
    }
    return false;
  }

  calculate() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(mathOperation);
      ContextModel cm = ContextModel();
      setState(() {
        result = exp.evaluate(EvaluationType.REAL, cm).toString();
      });
    } catch (e) {
      setState(() {
        result = e.toString();
      });
    }
  }
}
