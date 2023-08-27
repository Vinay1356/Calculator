import 'package:calculator_app/providers/theme_changer_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNumber = 0.0;
  double secondNumber = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    // if value is AC
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '⌫') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('X', '*').replaceAll('%', '/100*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52.0;
      }
    }  else {
      input = input + value;
      hideInput = false;
      outputSize = 34.0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    final containerBackgroundColor =
    themeChanger.themeMode == ThemeMode.dark ? Colors.black45 : Colors.white;
    final textColor = themeChanger.themeMode == ThemeMode.dark ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          IconButton(
          icon: themeChanger.themeMode == ThemeMode.dark
              ? const Icon(Icons.wb_sunny)
                : const Icon(Icons.nightlight_round),
        onPressed: () {
          themeChanger.toggleTheme();
        },
          ),
            ],
          ),
        ),
      ),
      // backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //Input and output area
          Container(
            margin: const EdgeInsets.all(10.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: containerBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.redAccent, width: 2),
              boxShadow: const [
                BoxShadow(
                  // color: Color(0xffffffff),
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 0.0),
                )
              ],
            ),
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideInput ? '' : input,
                      style: TextStyle(
                        fontSize: 45,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      output,
                      style: TextStyle(
                        fontSize: outputSize,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                )),
          ),
          Row(children: [
            button(
              text: 'AC',
              bottomBGcolor: CupertinoColors.darkBackgroundGray,
              tColor: kOperatorColor,
            ),
            button(
              text: '⌫',
              bottomBGcolor: CupertinoColors.darkBackgroundGray,
              tColor: kOperatorColor,
            ),
            button(
              text: '%',
              bottomBGcolor: CupertinoColors.darkBackgroundGray,
              tColor: kOperatorColor,
            ),
            button(
                text: '/',
                bottomBGcolor: CupertinoColors.darkBackgroundGray,
                tColor: kOperatorColor),
          ]),
          Row(children: [
            button(text: '7'),
            button(text: '8'),
            button(text: '9'),
            button(
                text: 'X',
                tColor: kOperatorColor,
                bottomBGcolor: CupertinoColors.darkBackgroundGray),
          ]),
          Row(children: [
            button(text: '4'),
            button(text: '5'),
            button(text: '6'),
            button(
                text: '-',
                tColor: kOperatorColor,
                bottomBGcolor: CupertinoColors.darkBackgroundGray),
          ]),
          Row(children: [
            button(text: '1'),
            button(text: '2'),
            button(text: '3'),
            button(
                text: '+',
                tColor: kOperatorColor,
                bottomBGcolor: CupertinoColors.darkBackgroundGray),
          ]),
          Row(children: [
            button(text: '0'),
            button(
                text: '.',
                tColor: kOperatorColor,
                bottomBGcolor: CupertinoColors.darkBackgroundGray),
            button(
                text: '=',
                bottomBGcolor: CupertinoColors.darkBackgroundGray,
                tColor: Colors.red),
          ]),
        ],
      ),
    );
  }

  Widget button({
    String? text,
    IconData? iconData,
    Color tColor = Colors.white,
    Color bottomBGcolor = kButtonColor,
  }) {
    return Expanded(
      flex: 1, // Add the flex property here
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: bottomBGcolor,
            padding: const EdgeInsets.all(22),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text!,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
