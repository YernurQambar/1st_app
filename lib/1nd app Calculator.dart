import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreen();
}

class _CalculatorScreen extends State<CalculatorScreen> {
  String output = '0';
  String _output = '';
  double num1 = 0;
  double num2 = 0;
  String operand = '';

  void buttonPresses(String buttonText) {
    if (buttonText == 'AC') {
      _output = '';
      num1 = 0;
      num2 = 0;
      operand = '';
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/') {
      if (_output.isNotEmpty) {
        num1 = double.parse(_output);
        operand = buttonText;
        _output = '';
      }
    } else if (buttonText == '=') {
      if (_output.isNotEmpty && operand.isNotEmpty) {
        num2 = double.parse(_output);
        switch (operand) {
          case '+':
            _output = (num1 + num2).toString();
            break;
          case '-':
            _output = (num1 - num2).toString();
            break;
          case '*':
            _output = (num1 * num2).toString();
            break;
          case '/':
            _output = (num2 != 0) ? (num1 / num2).toString() : 'Error';
            break;
        }
        num1 = 0;
        num2 = 0;
        operand = '';
      }
    } else if (buttonText == '±' && _output.isNotEmpty) {
      if (_output.startsWith('-')) {
        _output = _output.substring(1);
      } else {
        _output = '-$_output';
      }
    } else {
      if (_output == '0' && buttonText != '.') {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
    }

    setState(() {
      output = _output.isEmpty ? '0' : _output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          "Calculator App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(top: 240, right: 12, left: 12),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48, color: Colors.white),
            ),
          ),
          const Divider(color: Colors.grey),
          Column(
            children: [
              buildRow(
                ["AC", "±", "%", "/"],
                [
                  Colors.grey[800]!,
                  Colors.grey[800]!,
                  Colors.grey[800]!,
                  Colors.orange,
                ],
              ),
              buildRow(
                ["7", "8", "9", "*"],
                [
                  Colors.grey[800]!,
                  Colors.grey[800]!,
                  Colors.grey[800]!,
                  Colors.orange,
                ],
              ),
              buildRow(
                ["4", "5", "6", "-"],
                [
                  Colors.grey[800]!,
                  Colors.grey[800]!,
                  Colors.grey[800]!,
                  Colors.orange,
                ],
              ),
              buildRow(
                ["1", "2", "3", "+"],
                [
                  Colors.grey[800]!,
                  Colors.grey[800]!,
                  Colors.grey[800]!,
                  Colors.orange,
                ],
              ),
              buildRow(
                [".", "0", "="],
                [Colors.grey[800]!, Colors.grey[800]!, Colors.orange],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRow(List<String> texts, List<Color> colors) {
    return Row(
      children: List.generate(texts.length, (index) {
        return Expanded(child: buildButton(texts[index], colors[index]));
      }),
    );
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          buttonPresses(buttonText);
        },
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
