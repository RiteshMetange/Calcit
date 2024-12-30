import 'package:flutter/material.dart';

// this is UI file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcbutton(String btntext, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Add button functionality
        calculation(btntext);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: btncolor,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        minimumSize: const Size(80, 80),
      ),
      child: Text(
        btntext,
        style: TextStyle(fontSize: 35, color: txtcolor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Calculator",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //calculator display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        text, // The variable showing the result
                        style:
                            const TextStyle(color: Colors.white, fontSize: 80),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //   buttons will be called here
              calcbutton('AC', Colors.grey.shade200, Colors.black),
              calcbutton('+/-', Colors.grey.shade200, Colors.black),
              calcbutton('%', Colors.grey.shade200, Colors.black),
              calcbutton('/', Colors.amber.shade600, Colors.black87),
            ]),
            const SizedBox(height: 10),

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //   buttons will be called here
              calcbutton('7', Colors.grey.shade900, Colors.white),
              calcbutton('8', Colors.grey.shade900, Colors.white),
              calcbutton('9', Colors.grey.shade900, Colors.white),
              calcbutton('x', Colors.amber.shade600, Colors.black87),
            ]),
            const SizedBox(height: 10),

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //   buttons will be called here
              calcbutton('4', Colors.grey.shade900, Colors.white),
              calcbutton('5', Colors.grey.shade900, Colors.white),
              calcbutton('6', Colors.grey.shade900, Colors.white),
              calcbutton('-', Colors.amber.shade600, Colors.black87),
            ]),
            const SizedBox(height: 10),

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //   buttons will be called here
              calcbutton('1', Colors.grey.shade900, Colors.white),
              calcbutton('2', Colors.grey.shade900, Colors.white),
              calcbutton('3', Colors.grey.shade900, Colors.white),
              calcbutton('+', Colors.amber.shade600, Colors.black87),
            ]),

            const SizedBox(height: 10),Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //   buttons will be called here
              calcbutton('0', Colors.grey.shade900, Colors.white),
              calcbutton('00', Colors.grey.shade900, Colors.white),
              calcbutton('.', Colors.grey.shade900, Colors.white),
              calcbutton('=', Colors.greenAccent, Colors.black87),
            ]),
            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  dynamic operationText = '';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(String btnText) {
    if (btnText == 'AC') {
      // Reset everything
      text = '0';
      operationText = '';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (btnText == '=' && opr.isNotEmpty) {
      // Perform calculation
      numTwo = double.parse(result);
      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }

      operationText += btnText; // Append "="
      operationText = ''; // Clear after showing result
      text = finalResult;
    } else if (['+', '-', 'x', '/'].contains(btnText)) {
      // Handle operator input
      if (result.isNotEmpty) {
        numOne = double.parse(result);
        opr = btnText;
        result = '';
        operationText += btnText; // Append operator to the operationText
      }
    } else {
      // Handle number input
      result += btnText;
      operationText += btnText; // Append number to the operationText
      text = result; // Update text for display
    }

    setState(() {});
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
