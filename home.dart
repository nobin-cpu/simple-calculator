import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultSize = 48.0;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Container(
            height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
            color: buttonColor,
            child: TextButton(
                onPressed: () {
                  buttonPressed(buttonText);
                },
                child: Text(
                  buttonText,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))))),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CALCULATOR'),
      ),
      body: Column(children: [
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            equation, 
            style: TextStyle(fontSize: equationFontSize),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            result,
            style: TextStyle(fontSize: resultSize),
          ),
        ),
        Expanded(
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("C", 1, Colors.redAccent),
                    buildButton("⌫", 1, Colors.blue),
                    buildButton("÷", 1, Colors.blue),
                  ]),
                  TableRow(children: [
                    buildButton("7", 1, Colors.black54),
                    buildButton("8", 1, Colors.black54),
                    buildButton("9", 1, Colors.black54),
                  ]),
                  TableRow(children: [
                    buildButton("4", 1, Colors.black54),
                    buildButton("5", 1, Colors.black54),
                    buildButton("6", 1, Colors.black54),
                  ]),
                  TableRow(children: [
                    buildButton("1", 1, Colors.black54),
                    buildButton("2", 1, Colors.black54),
                    buildButton("3", 1, Colors.black54),
                  ]),
                  TableRow(children: [
                    buildButton(".", 1, Colors.black54),
                    buildButton("0", 1, Colors.black54),
                    buildButton("00", 1, Colors.black54),
                  ]),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Table(children: [
                TableRow(children: [buildButton('×', 1, Colors.blue)]),
                TableRow(children: [buildButton("-", 1, Colors.blue)]),
                TableRow(children: [buildButton("+", 1, Colors.blue)]),
                TableRow(children: [buildButton("=", 2, Colors.redAccent)])
              ]),
            )
          ],
        )
      ]),
    );
  }
}
